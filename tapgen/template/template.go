package template

import (
	"bytes"
	"embed"
	_ "embed"
	"sync"
	"text/template"

	"github.com/patrickdappollonio/homebrew-tap/tapgen/cfg"
	"github.com/patrickdappollonio/homebrew-tap/tapgen/github"
)

var (
	//go:embed *.gotmpl
	files embed.FS

	compiled *template.Template
	once     sync.Once
)

func GenerateFormula(config cfg.Config, tag string, downloads []github.Download) (string, error) {
	once.Do(func() {
		compiled = template.Must(template.New("formula").Funcs(funcmap).ParseFS(files, "*.gotmpl"))
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
	if err := compiled.ExecuteTemplate(&buf, "formula.rb.gotmpl", payload); err != nil {
		return "", err
	}

	return buf.String(), nil
}

func GenerateReadme(configs []cfg.Config) (string, error) {
	once.Do(func() {
		compiled = template.Must(template.New("formula").Funcs(funcmap).ParseFS(files, "*.gotmpl"))
	})

	var buf bytes.Buffer
	if err := compiled.ExecuteTemplate(&buf, "readme.md.gotmpl", map[string]any{
		"Configs": configs,
	}); err != nil {
		return "", err
	}

	return buf.String(), nil
}
