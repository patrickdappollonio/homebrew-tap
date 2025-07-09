// Package github provides functionality for interacting with GitHub releases and downloads.
package github

import (
	"bufio"
	"encoding/json"
	"fmt"
	"os"
	"regexp"
	"strings"
)

// cacheCommentRegex matches Ruby comments containing cache JSON.
var cacheCommentRegex = regexp.MustCompile(`^#\s*TAPGEN_CACHE:\s*(.+)$`)

// ParseCacheFromFormula reads an existing Ruby formula file and extracts cache information.
func ParseCacheFromFormula(filename string) (*FormulaCache, error) {
	file, err := os.Open(filename)
	if err != nil {
		if os.IsNotExist(err) {
			return nil, nil // No cache available
		}
		return nil, fmt.Errorf("failed to open formula file %q: %w", filename, err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		if matches := cacheCommentRegex.FindStringSubmatch(line); len(matches) > 1 {
			var cache FormulaCache
			if err := json.Unmarshal([]byte(matches[1]), &cache); err != nil {
				return nil, fmt.Errorf("failed to parse cache JSON from %q: %w", filename, err)
			}
			return &cache, nil
		}
	}

	if err := scanner.Err(); err != nil {
		return nil, fmt.Errorf("failed to read formula file %q: %w", filename, err)
	}

	return nil, nil // No cache found
}

// FormatCacheComment formats cache data as a Ruby comment for embedding in formula files.
func FormatCacheComment(cache *FormulaCache) (string, error) {
	if cache == nil {
		return "", nil
	}

	cacheJSON, err := json.Marshal(cache)
	if err != nil {
		return "", fmt.Errorf("failed to marshal cache to JSON: %w", err)
	}

	return fmt.Sprintf("# TAPGEN_CACHE: %s", string(cacheJSON)), nil
}
