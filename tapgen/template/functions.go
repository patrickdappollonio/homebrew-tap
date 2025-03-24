package template

import (
	"fmt"
	"strings"
	"text/template"
	"time"

	"golang.org/x/text/cases"
	"golang.org/x/text/language"
)

var funcmap = template.FuncMap{
	"toLower":       strings.ToLower,
	"toUpper":       strings.ToUpper,
	"quote":         func(s string) string { return fmt.Sprintf("%q", s) },
	"printf":        func(format string, args ...interface{}) string { return fmt.Sprintf(format, args...) },
	"trimPrefix":    func(prefix, s string) string { return strings.TrimPrefix(s, prefix) },
	"trimSuffix":    func(suffix, s string) string { return strings.TrimSuffix(s, suffix) },
	"lowerAlphaNum": LowercaseNoDashes,
	"classify":      classify,
	"now":           func() string { return time.Now().Format(time.RFC850) },
	"indent":        indent,
	"nindent":       nindent,
	"stringsJoin":   strings.Join,
}

func indent(spaces int, v string) string {
	pad := strings.Repeat(" ", spaces)
	return pad + strings.Replace(v, "\n", "\n"+pad, -1)
}

func nindent(spaces int, v string) string {
	return "\n" + indent(spaces, v)
}

func classify(str string) string {
	str = strings.ToLower(str)

	str = strings.NewReplacer(
		"-", " ",
		"_", " ",
	).Replace(str)

	str = strings.Map(func(r rune) rune {
		if (r >= 'a' && r <= 'z') || (r >= '0' && r <= '9') || r == '-' || r == ' ' {
			return r
		}
		return -1
	}, str)

	str = cases.Title(language.English).String(str)
	str = strings.ReplaceAll(str, " ", "")

	return str
}

func LowercaseNoDashes(str string) string {
	str = strings.ToLower(str)
	return strings.Map(func(r rune) rune {
		if (r >= 'a' && r <= 'z') || (r >= '0' && r <= '9') {
			return r
		}
		return -1
	}, str)
}
