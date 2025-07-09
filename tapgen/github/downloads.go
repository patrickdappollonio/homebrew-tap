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

// Compiled regular expressions for platform and architecture detection.
var (
	reARM64  = regexp.MustCompile(`(\b|_|-)arm64(\b|_|-)`)
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
		return fmt.Errorf("failed to create request: %w", err)
	}

	req.Header.Set("X-Github-Api-Version", "2022-11-28")
	if token != "" {
		req.Header.Set("Authorization", "Bearer "+token)
	}

	resp, err := client.Do(req)
	if err != nil {
		return fmt.Errorf("failed to perform request: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("unexpected status code: %d", resp.StatusCode)
	}

	if buf != nil {
		if _, err := buf.ReadFrom(resp.Body); err != nil {
			return fmt.Errorf("failed to read response body: %w", err)
		}
	}

	return nil
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
	Name               string `json:"name"`
	State              string `json:"state"`
	BrowserDownloadURL string `json:"browser_download_url"`
}

// GetLatestDownloads fetches the latest release downloads for the specified repository.
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
		return "", fmt.Errorf("failed to create request: %w", err)
	}

	if token != "" {
		req.Header.Set("Authorization", "Bearer "+token)
	}

	resp, err := client.Do(req)
	if err != nil {
		return "", fmt.Errorf("failed to perform request: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return "", fmt.Errorf("unexpected status code: %d", resp.StatusCode)
	}

	hasher := sha256.New()
	if _, err := io.Copy(hasher, resp.Body); err != nil {
		return "", fmt.Errorf("failed to calculate hash: %w", err)
	}

	return fmt.Sprintf("%x", hasher.Sum(nil)), nil
}
