// Package github provides functionality for interacting with GitHub releases and downloads.
package github

import (
	"bytes"
	"context"
	"crypto/sha256"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"regexp"
	"strings"
	"time"

	"github.com/patrickdappollonio/retryhttp"
)

// HTTPError represents an HTTP error with additional context.
type HTTPError struct {
	URL        string
	StatusCode int
	Body       string
	Err        error
}

// Error returns the error message with HTTP context.
func (e *HTTPError) Error() string {
	if e.StatusCode != 0 {
		if e.Body != "" {
			// Truncate body if it's too long
			body := e.Body
			if len(body) > 200 {
				body = body[:200] + "..."
			}
			return fmt.Sprintf("HTTP %d for %s: %s (response: %s)", e.StatusCode, e.URL, e.Err.Error(), body)
		}
		return fmt.Sprintf("HTTP %d for %s: %s", e.StatusCode, e.URL, e.Err.Error())
	}
	return fmt.Sprintf("request to %s failed: %s", e.URL, e.Err.Error())
}

// Unwrap returns the underlying error.
func (e *HTTPError) Unwrap() error {
	return e.Err
}

// Compiled regular expressions for platform and architecture detection.
var (
	reARM64  = regexp.MustCompile(`(\b|_|-)(arm64|aarch64)(\b|_|-)`)
	reARM    = regexp.MustCompile(`(\b|_|-)arm(\b|_|-)`)
	reLinux  = regexp.MustCompile(`(\b|_|-)linux(\b|_|-)`)
	re64Bits = regexp.MustCompile(`(\b|_|-)(amd64|x?86_64)(\b|_|-)`)
	reDarwin = regexp.MustCompile(`(\b|_|-)(darwin|macos)(\b|_|-)`)
)

// Download represents a downloadable asset from a GitHub release.
type Download struct {
	Filename string
	URL      string
	SHA256   string
}

// CachedAsset represents a cached asset with its GitHub ID and calculated SHA256.
type CachedAsset struct {
	ID       int64  `json:"id"`
	Filename string `json:"filename"`
	URL      string `json:"url"`
	SHA256   string `json:"sha256"`
}

// FormulaCache represents cached data for a Homebrew formula.
type FormulaCache struct {
	Tag        string        `json:"tag"`
	Repository string        `json:"repository"`
	CachedAt   time.Time     `json:"cached_at"`
	Assets     []CachedAsset `json:"assets"`
}

// FilenameLower returns the filename in lowercase for case-insensitive comparisons.
func (d Download) FilenameLower() string {
	return strings.ToLower(d.Filename)
}

// IsMacOS returns true if the download is for macOS.
func (d Download) IsMacOS() bool {
	return reDarwin.MatchString(d.FilenameLower())
}

// IsLinux returns true if the download is for Linux.
func (d Download) IsLinux() bool {
	return reLinux.MatchString(d.FilenameLower())
}

// IsIntel returns true if the download is for Intel/AMD64 architecture.
func (d Download) IsIntel() bool {
	return re64Bits.MatchString(d.FilenameLower())
}

// IsARM64 returns true if the download is for ARM64 architecture.
func (d Download) IsARM64() bool {
	return reARM64.MatchString(d.FilenameLower())
}

// IsARM returns true if the download is for ARM (non-64bit) architecture.
func (d Download) IsARM() bool {
	return reARM.MatchString(d.FilenameLower())
}

// client is the HTTP client used for all requests with retry logic.
var client = retryhttp.New(
	retryhttp.WithMaxRetries(3),
	retryhttp.WithInitialBackoff(250*time.Millisecond),
	retryhttp.WithBackoffMultiplier(2),
	retryhttp.WithCondition(func(resp *http.Response, err error) bool {
		if err != nil {
			return true
		}
		// Sometimes GitHub returns a 403 Forbidden error for rate limiting, so this
		// would attempt to retry the request some time after.
		return resp.StatusCode == http.StatusForbidden
	}),
)

// doJSONGet performs a GET request and unmarshals the response into the provided value.
func doJSONGet[T any](ctx context.Context, token, url string, v *T) error {
	buf := new(bytes.Buffer)
	if err := doGet(ctx, token, url, buf); err != nil {
		return err
	}

	if err := json.Unmarshal(buf.Bytes(), v); err != nil {
		return fmt.Errorf("failed to unmarshal JSON: %w", err)
	}

	return nil
}

// doGet performs a GET request to the specified URL with optional authentication.
func doGet(ctx context.Context, token, url string, buf *bytes.Buffer) error {
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, url, nil)
	if err != nil {
		return &HTTPError{
			URL: url,
			Err: fmt.Errorf("failed to create request: %w", err),
		}
	}

	req.Header.Set("X-Github-Api-Version", "2022-11-28")
	if token != "" {
		req.Header.Set("Authorization", "Bearer "+token)
	}

	resp, err := client.Do(req)
	if err != nil {
		return enhanceErrorWithContext(url, token, err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		body, _ := io.ReadAll(io.LimitReader(resp.Body, 1024))
		return &HTTPError{
			URL:        url,
			StatusCode: resp.StatusCode,
			Body:       string(body),
			Err:        fmt.Errorf("unexpected status code: %d", resp.StatusCode),
		}
	}

	if buf != nil {
		if _, err := buf.ReadFrom(resp.Body); err != nil {
			return &HTTPError{
				URL: url,
				Err: fmt.Errorf("failed to read response body: %w", err),
			}
		}
	}

	return nil
}

// enhanceErrorWithContext tries to extract response information from retry errors.
func enhanceErrorWithContext(url, token string, err error) error {
	// Try to perform one more request to get the last response for debugging
	// This is a best-effort attempt to get response context
	req, reqErr := http.NewRequest(http.MethodGet, url, nil)
	if reqErr != nil {
		return &HTTPError{
			URL: url,
			Err: fmt.Errorf("failed to perform request: %w", err),
		}
	}

	// Set the same headers as the original request
	req.Header.Set("X-Github-Api-Version", "2022-11-28")
	if token != "" {
		req.Header.Set("Authorization", "Bearer "+token)
	}

	// Create a simple client without retries for this debug request
	simpleClient := &http.Client{Timeout: 10 * time.Second}
	resp, respErr := simpleClient.Do(req)
	if respErr != nil {
		return &HTTPError{
			URL: url,
			Err: fmt.Errorf("failed to perform request: %w", err),
		}
	}
	defer resp.Body.Close()

	// Read the response body (limit to avoid memory issues)
	body, _ := io.ReadAll(io.LimitReader(resp.Body, 1024))

	return &HTTPError{
		URL:        url,
		StatusCode: resp.StatusCode,
		Body:       string(body),
		Err:        fmt.Errorf("failed to perform request: %w", err),
	}
}

// repositoryURL is the GitHub API URL template for fetching latest releases.
const repositoryURL = "https://api.github.com/repos/%s/releases/latest"

// release represents a GitHub release response.
type release struct {
	TagName    string         `json:"tag_name"`
	Draft      bool           `json:"draft"`
	Prerelease bool           `json:"prerelease"`
	Assets     []releaseAsset `json:"assets"`
}

// releaseAsset represents a single asset in a GitHub release.
type releaseAsset struct {
	ID                 int64  `json:"id"`
	Name               string `json:"name"`
	State              string `json:"state"`
	BrowserDownloadURL string `json:"browser_download_url"`
}

// GetLatestDownloads fetches the latest release downloads for the specified repository.
// It uses caching to avoid downloading files when asset IDs haven't changed.
func GetLatestDownloads(ctx context.Context, token, repoName string) (string, []Download, error) {
	url := fmt.Sprintf(repositoryURL, repoName)

	var rel release
	if err := doJSONGet(ctx, token, url, &rel); err != nil {
		return "", nil, fmt.Errorf("failed to get latest release: %w", err)
	}

	if len(rel.Assets) == 0 {
		return "", nil, fmt.Errorf("no assets found for release %s", rel.TagName)
	}

	qualifyingAssets, err := filterAndProcessAssets(ctx, token, rel.Assets, rel.Draft, rel.Prerelease)
	if err != nil {
		return "", nil, err
	}

	if len(qualifyingAssets) == 0 {
		return "", nil, fmt.Errorf("no qualifying assets found for release %s", rel.TagName)
	}

	return rel.TagName, qualifyingAssets, nil
}

// GetLatestDownloadsWithCache fetches the latest release downloads using cache when possible.
func GetLatestDownloadsWithCache(ctx context.Context, token, repoName string, existingCache *FormulaCache) (string, []Download, *FormulaCache, error) {
	url := fmt.Sprintf(repositoryURL, repoName)

	var rel release
	if err := doJSONGet(ctx, token, url, &rel); err != nil {
		return "", nil, nil, fmt.Errorf("failed to get latest release: %w", err)
	}

	if len(rel.Assets) == 0 {
		return "", nil, nil, fmt.Errorf("no assets found for release %s", rel.TagName)
	}

	// Check if we can use cache
	if existingCache != nil && existingCache.Tag == rel.TagName && existingCache.Repository == repoName {
		if cachedDownloads := tryUseCache(rel.Assets, existingCache); cachedDownloads != nil {
			log.Printf("Using cached downloads for %s (tag: %s) - no asset changes detected", repoName, rel.TagName)
			return rel.TagName, cachedDownloads, existingCache, nil
		}
	}

	// Cache miss or invalid - process assets normally
	log.Printf("Cache miss for %s (tag: %s) - processing assets", repoName, rel.TagName)
	qualifyingAssets, err := filterAndProcessAssets(ctx, token, rel.Assets, rel.Draft, rel.Prerelease)
	if err != nil {
		return "", nil, nil, err
	}

	if len(qualifyingAssets) == 0 {
		return "", nil, nil, fmt.Errorf("no qualifying assets found for release %s", rel.TagName)
	}

	// Create new cache
	newCache := &FormulaCache{
		Tag:        rel.TagName,
		Repository: repoName,
		CachedAt:   time.Now(),
		Assets:     make([]CachedAsset, len(qualifyingAssets)),
	}

	for i, download := range qualifyingAssets {
		// Find the corresponding asset to get its ID
		found := false
		for _, asset := range rel.Assets {
			if asset.Name == download.Filename {
				newCache.Assets[i] = CachedAsset{
					ID:       asset.ID,
					Filename: download.Filename,
					URL:      download.URL,
					SHA256:   download.SHA256,
				}
				found = true
				break
			}
		}
		if !found {
			return "", nil, nil, fmt.Errorf("failed to find asset ID for download %q", download.Filename)
		}
	}

	return rel.TagName, qualifyingAssets, newCache, nil
}

// tryUseCache attempts to use cached downloads if all asset IDs match.
func tryUseCache(currentAssets []releaseAsset, cache *FormulaCache) []Download {
	// Create a map of current asset IDs to assets
	currentAssetMap := make(map[int64]releaseAsset)
	for _, asset := range currentAssets {
		currentAssetMap[asset.ID] = asset
	}

	// Check if all cached assets still exist with the same IDs
	downloads := make([]Download, 0, len(cache.Assets))
	for _, cachedAsset := range cache.Assets {
		if currentAsset, exists := currentAssetMap[cachedAsset.ID]; exists {
			// Asset ID still exists, use cached data
			download := Download{
				Filename: currentAsset.Name,
				URL:      currentAsset.BrowserDownloadURL,
				SHA256:   cachedAsset.SHA256,
			}

			// Verify it's still a valid platform/architecture
			if isValidPlatform(download) && isValidArchitecture(download) {
				downloads = append(downloads, download)
			}
		} else {
			// Asset ID changed, cache is invalid
			return nil
		}
	}

	return downloads
}

// filterAndProcessAssets filters release assets and calculates their SHA256 hashes.
func filterAndProcessAssets(ctx context.Context, token string, assets []releaseAsset, isDraft, isPrerelease bool) ([]Download, error) {
	qualifyingAssets := make([]Download, 0, len(assets))

	for _, asset := range assets {
		if asset.State != "uploaded" || isDraft || isPrerelease {
			continue
		}

		download := Download{
			Filename: asset.Name,
			URL:      asset.BrowserDownloadURL,
		}

		if !isValidPlatform(download) {
			log.Printf("skipping non MacOS or Linux asset %q", asset.BrowserDownloadURL)
			continue
		}

		if !isValidArchitecture(download) {
			log.Printf("skipping non Intel or ARM(64) asset %q", asset.BrowserDownloadURL)
			continue
		}

		sha, err := calculateSHAForDownload(ctx, token, asset.BrowserDownloadURL)
		if err != nil {
			return nil, fmt.Errorf("failed to calculate SHA for %q: %w", asset.BrowserDownloadURL, err)
		}
		download.SHA256 = sha

		qualifyingAssets = append(qualifyingAssets, download)
	}

	return qualifyingAssets, nil
}

// isValidPlatform checks if the download is for a supported platform.
func isValidPlatform(download Download) bool {
	return download.IsMacOS() || download.IsLinux()
}

// isValidArchitecture checks if the download is for a supported architecture.
func isValidArchitecture(download Download) bool {
	return download.IsIntel() || download.IsARM64() || download.IsARM()
}

// calculateSHAForDownload downloads a file and calculates its SHA256 hash.
func calculateSHAForDownload(ctx context.Context, token, url string) (string, error) {
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, url, nil)
	if err != nil {
		return "", &HTTPError{
			URL: url,
			Err: fmt.Errorf("failed to create request: %w", err),
		}
	}

	if token != "" {
		req.Header.Set("Authorization", "Bearer "+token)
	}

	resp, err := client.Do(req)
	if err != nil {
		return "", enhanceErrorWithContext(url, token, err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		body, _ := io.ReadAll(io.LimitReader(resp.Body, 1024))
		return "", &HTTPError{
			URL:        url,
			StatusCode: resp.StatusCode,
			Body:       string(body),
			Err:        fmt.Errorf("unexpected status code: %d", resp.StatusCode),
		}
	}

	hasher := sha256.New()
	if _, err := io.Copy(hasher, resp.Body); err != nil {
		return "", &HTTPError{
			URL: url,
			Err: fmt.Errorf("failed to calculate hash: %w", err),
		}
	}

	return fmt.Sprintf("%x", hasher.Sum(nil)), nil
}
