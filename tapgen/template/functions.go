// Package template provides template functions and utilities for generating Homebrew formulas.
package template

import (
	"fmt"
	"strings"
	"text/template"
	"time"

	"github.com/patrickdappollonio/homebrew-tap/tapgen/cfg"
	"golang.org/x/text/cases"
	"golang.org/x/text/language"
)

// funcmap contains all template functions available in Homebrew formula templates.
var funcmap = template.FuncMap{
	"toLower":       strings.ToLower,
	"toUpper":       strings.ToUpper,
	"quote":         quote,
	"printf":        fmt.Sprintf,
	"trimPrefix":    func(prefix, s string) string { return strings.TrimPrefix(s, prefix) },
	"trimSuffix":    func(suffix, s string) string { return strings.TrimSuffix(s, suffix) },
	"lowerAlphaNum": normalizeForTemplate,
	"classify":      classify,
	"now":           getCurrentTime,
	"indent":        indent,
	"nindent":       nindent,
	"stringsJoin":   strings.Join,
}

// quote wraps a string in double quotes for use in templates.
func quote(s string) string {
	return fmt.Sprintf("%q", s)
}

// getCurrentTime returns the current time in RFC850 format.
func getCurrentTime() string {
	return time.Now().Format(time.RFC850)
}

// indent adds the specified number of spaces to the beginning of each line.
func indent(spaces int, v string) string {
	pad := strings.Repeat(" ", spaces)
	return pad + strings.ReplaceAll(v, "\n", "\n"+pad)
}

// nindent adds a newline followed by the specified number of spaces to the beginning of each line.
func nindent(spaces int, v string) string {
	return "\n" + indent(spaces, v)
}

// classify converts a string to a Go-style class name (PascalCase).
func classify(str string) string {
	// Convert to lowercase first
	str = strings.ToLower(str)

	// Replace separators with spaces
	str = strings.NewReplacer("-", " ", "_", " ").Replace(str)

	// Keep only alphanumeric characters and spaces
	str = strings.Map(func(r rune) rune {
		if (r >= 'a' && r <= 'z') || (r >= '0' && r <= '9') || r == ' ' {
			return r
		}
		return -1
	}, str)

	// Convert to title case and remove spaces
	str = cases.Title(language.English).String(str)
	return strings.ReplaceAll(str, " ", "")
}

// normalizeForTemplate normalizes a string for use in templates by delegating to cfg.Config.NormalizedName.
// This is a bridge function to avoid code duplication.
func normalizeForTemplate(str string) string {
	// Create a temporary config to use the normalized name function
	config := cfg.Config{Name: str}
	return config.NormalizedName()
}
