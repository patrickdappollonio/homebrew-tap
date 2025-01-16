package template

import (
	"bytes"
	_ "embed"
	"fmt"
	"strings"
	"sync"
	"text/template"
	"time"

	"github.com/patrickdappollonio/homebrew-tap/tapgen/cfg"
	"github.com/patrickdappollonio/homebrew-tap/tapgen/github"
	"golang.org/x/text/cases"
	"golang.org/x/text/language"
)

var (
	//go:embed formula.rb.gotmpl
	formula string

	once     sync.Once
	compiled *template.Template
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

func GenerateFormula(config cfg.Config, tag string, downloads []github.Download) (string, error) {
	once.Do(func() {
		compiled = template.Must(template.New("formula").Funcs(funcmap).Parse(formula))
	})

	payload := struct {
		Config         cfg.Config
		MacOSDownloads []github.Download
		LinuxDownloads []github.Download
		Tag            string
	}{
		Config: config,
		Tag:    tag,
	}

	for _, d := range downloads {
		if d.IsMacOS() {
			payload.MacOSDownloads = append(payload.MacOSDownloads, d)
		} else if d.IsLinux() {
			payload.LinuxDownloads = append(payload.LinuxDownloads, d)
		}
	}

	var buf bytes.Buffer
	if err := compiled.Execute(&buf, payload); err != nil {
		return "", err
	}

	return buf.String(), nil
}
