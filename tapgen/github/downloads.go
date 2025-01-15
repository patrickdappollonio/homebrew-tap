package github

import (
	"bytes"
	"context"
	"crypto/sha256"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"regexp"
	"strings"
)

var (
	reARM64  = regexp.MustCompile(`(\b|_|-)arm64(\b|_|-)`)
	reARM    = regexp.MustCompile(`(\b|_|-)arm(\b|_|-)`)
	reLinux  = regexp.MustCompile(`(\b|_|-)linux(\b|_|-)`)
	re64Bits = regexp.MustCompile(`(\b|_|-)(amd64|x?86_64)(\b|_|-)`)
	reDarwin = regexp.MustCompile(`(\b|_|-)(darwin|macos)(\b|_|-)`)
)

type Download struct {
	Filename string
	URL      string
	SHA256   string
}

func (d Download) FilenameLower() string {
	return strings.ToLower(d.Filename)
}

func (d Download) IsMacOS() bool {
	return reDarwin.MatchString(d.FilenameLower())
}

func (d Download) IsLinux() bool {
	return reLinux.MatchString(d.FilenameLower())
}

func (d Download) IsIntel() bool {
	return re64Bits.MatchString(d.FilenameLower())
}

func (d Download) IsARM64() bool {
	return reARM64.MatchString(d.FilenameLower())
}

func (d Download) IsARM() bool {
	return reARM.MatchString(d.FilenameLower())
}

var client = &http.Client{Transport: http.DefaultTransport}

func doJSONGet(ctx context.Context, token, url string, v interface{}) error {
	buf := new(bytes.Buffer)
	if err := doGet(ctx, token, url, buf); err != nil {
		return err
	}

	if err := json.Unmarshal(buf.Bytes(), v); err != nil {
		return fmt.Errorf("could not unmarshal JSON: %w", err)
	}

	return nil
}

func doGet(ctx context.Context, token, url string, buf *bytes.Buffer) error {
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, url, nil)
	if err != nil {
		return fmt.Errorf("could not create request: %w", err)
	}

	req.Header.Set("X-Github-Api-Version", "2022-11-28")

	if token != "" {
		req.Header.Set("Authorization", "Bearer "+token)
	}

	resp, err := client.Do(req)
	if err != nil {
		return fmt.Errorf("could not perform request: %w", err)
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("unexpected status code: %d", resp.StatusCode)
	}

	if buf != nil {
		if _, err := buf.ReadFrom(resp.Body); err != nil {
			return fmt.Errorf("could not read response body: %w", err)
		}
	}

	return nil
}

const repositoryURL = "https://api.github.com/repos/%s/releases/latest"

type release struct {
	TagName    string         `json:"tag_name"`
	Draft      bool           `json:"draft"`
	Prerelease bool           `json:"prerelease"`
	Assets     []releaseAsset `json:"assets"`
}

type releaseAsset struct {
	Name               string `json:"name"`
	State              string `json:"state"`
	BrowserDownloadURL string `json:"browser_download_url"`
}

func GetLatestDownloads(ctx context.Context, token, repoName string) (string, []Download, error) {
	u := fmt.Sprintf(repositoryURL, repoName)

	var release release
	if err := doJSONGet(ctx, token, u, &release); err != nil {
		return "", nil, fmt.Errorf("could not get latest release: %w", err)
	}

	if len(release.Assets) == 0 {
		return "", nil, fmt.Errorf("no assets found for release %s", release.TagName)
	}

	qualifyingAssets := make([]Download, 0, len(release.Assets))
	for _, asset := range release.Assets {
		if asset.State != "uploaded" || release.Draft || release.Prerelease {
			continue
		}

		dwn := Download{
			Filename: asset.Name,
			URL:      asset.BrowserDownloadURL,
		}

		if !(dwn.IsMacOS() || dwn.IsLinux()) {
			log.Printf("skipping non MacOS or Linux asset %q", asset.BrowserDownloadURL)
			continue
		}

		if !(dwn.IsIntel() || dwn.IsARM64() || dwn.IsARM()) {
			log.Printf("skipping non Intel or ARM(64) asset %q", asset.BrowserDownloadURL)
			continue
		}

		sha, err := calculateSHAForDownload(ctx, token, asset.BrowserDownloadURL)
		if err != nil {
			return "", nil, fmt.Errorf("could not calculate SHA for %q: %w", asset.BrowserDownloadURL, err)
		}
		dwn.SHA256 = sha

		qualifyingAssets = append(qualifyingAssets, dwn)
	}

	if len(qualifyingAssets) == 0 {
		return "", nil, fmt.Errorf("no qualifying assets found for release %s", release.TagName)
	}

	return release.TagName, qualifyingAssets, nil
}

func calculateSHAForDownload(ctx context.Context, token, url string) (string, error) {
	buf := new(bytes.Buffer)
	if err := doGet(ctx, token, url, buf); err != nil {
		return "", fmt.Errorf("could not get download: %w", err)
	}

	return fmt.Sprintf("%x", sha256.Sum256(buf.Bytes())), nil
}
