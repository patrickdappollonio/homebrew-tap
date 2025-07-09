# PatrickDappollonio Homebrew Tap

This repository uses a tiny Go application that converts the repositories listed in [`config.yaml`](config.yaml) into Homebrew formulae.

This process runs daily using GitHub Actions, although it can also be triggered using a `workflow_dispatch`. The generated formulae are then pushed to the `Formula` directory in this repository and the `README.md` file is updated to reflect all available applications.

## How It Works

The application automatically detects the latest, non-draft, published version of the repository listed in the configuration file. It then generates a formula file with the necessary information to install the binary.

### Features

- **Automatic Release Detection**: Fetches the latest non-draft, published releases from GitHub
- **Multi-Platform Support**: Generates formulas for macOS (Intel/ARM64) and Linux (Intel/ARM64/ARM)
- **Intelligent Caching**: Uses asset ID-based caching to avoid unnecessary downloads
- **Custom README Templates**: Allows users to provide their own README template
- **Enhanced Error Handling**: Provides detailed error messages with HTTP status codes and response bodies
- **Flexible Configuration**: Supports aliases, binary renaming, license detection, and more

## Command-Line Usage

### Installation

Download the latest binary from the [releases page](https://github.com/patrickdappollonio/homebrew-tap/releases) or build from source:

```bash
go build -o homebrew-tap .
```

### Basic Usage

```bash
# Generate all formulas and README (uses readme.md.gotmpl by default)
./homebrew-tap

# Generate only a specific formula
./homebrew-tap --target http-server

# Use a custom README template
./homebrew-tap --readme-template my-custom-readme.md.gotmpl

# Use a custom config file
./homebrew-tap --config my-config.yaml
```

### Command-Line Flags

- `--config`, `-c`: Location of the configuration file (default: `config.yaml`)
- `--target`, `-t`: Only generate the formula for the specified package
- `--readme-template`, `-r`: Path to the README template file (default: `readme.md.gotmpl`)

### Environment Variables

- `GITHUB_TOKEN`: GitHub personal access token for API requests (recommended for higher rate limits)

## Custom README Templates

The tool uses README templates to generate the final README.md file. By default, it looks for `readme.md.gotmpl` in the current directory, but you can specify a custom template file using the `--readme-template` flag.

### Template Data

Your README template has access to the following data:

```go
type ReadmePayload struct {
    Configs []cfg.Config // Array of all configurations
}
```

### Template Functions

The following functions are available in your template:

- `toLower`, `toUpper`: String case conversion
- `quote`: Wrap string in double quotes
- `printf`: Format strings (like `fmt.Sprintf`)
- `trimPrefix`, `trimSuffix`: String trimming
- `classify`: Convert to PascalCase
- `now`: Current timestamp
- `indent`, `nindent`: Text indentation
- `stringsJoin`: Join string arrays

### Example Template

```go
# My Custom Homebrew Tap

{{- range .Configs }}
## {{ .Name }}

**Description:** {{ .Description }}
{{- if .License }}
**License:** {{ .License }}
{{- end }}
**Repository:** [{{ .Repository }}](https://github.com/{{ .Repository }})

```bash
brew install your-tap/{{ .Name }}
```

{{- end }}

---
*Generated on {{ now }}*
```

## Configuration Format

A configuration is defined as a list of repositories with the following settings:

```yaml
- name: example-app # binary name inside the compressed file
  repository: patrickdappollonio/example-app # GitHub repository
  description: "An example app" # description of the app
  url: https://example.com # optional homepage URL (defaults to GitHub repo)
  test_command: "example-app --version" # command to test the installation, can be empty
  license: MIT # SPDX license identifier
  install_aliases: # list of aliases to install the app, can be empty
    - example
  rename_binary: fooexample # rename the binary to this name upon installation, can be empty
  conflicts_with: # list of homebrew formulae that conflict with this one, can be empty
    - name: example
      reason: 'Both install an "example" binary.'
  caveats: |-
    This is a caveat for the example app.
    It can be multiline and supports Markdown.
```

### Configuration Options

| Field             | Type   | Required | Description                                  |
| ----------------- | ------ | -------- | -------------------------------------------- |
| `name`            | string | ✅        | Binary name and formula identifier           |
| `repository`      | string | ✅        | GitHub repository in `owner/repo` format     |
| `description`     | string | ✅        | Short description of the application         |
| `url`             | string | ❌        | Homepage URL (defaults to GitHub repository) |
| `test_command`    | string | ❌        | Command to test the installation             |
| `license`         | string | ❌        | SPDX license identifier                      |
| `install_aliases` | array  | ❌        | List of additional command aliases           |
| `rename_binary`   | string | ❌        | Rename the binary upon installation          |
| `conflicts_with`  | array  | ❌        | List of conflicting Homebrew formulae        |
| `caveats`         | string | ❌        | Additional installation notes                |

## GitHub Actions Integration

The repository uses GitHub Actions to automatically update formulas. The workflow:

1. Runs daily at midnight
2. Can be triggered manually with `workflow_dispatch`
3. Downloads the latest binary release
4. Generates formulas for all configured repositories
5. Updates the README using the template
6. Commits and pushes changes

### Workflow Configuration

```yaml
- name: Run application to generate Formulas
  run: |
    rm -rf Formula/*.rb README.md
    homebrew-tap --target "${{ github.event.inputs.target }}"
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

*Note: The workflow can now omit the `--readme-template` flag since it defaults to `readme.md.gotmpl`.*

## Error Handling

The application provides enhanced error messages for debugging:

### Rate Limiting
```
HTTP 403 for https://api.github.com/repos/user/repo/releases/latest: failed to perform request: max retries exceeded
(response: {"message":"API rate limit exceeded for 99.226.0.222. (But here's the good news: Authenticated requests get a higher rate limit..."})
```

### Authentication Issues
```
HTTP 401 for https://api.github.com/repos/user/repo/releases/latest: unexpected status code: 401
(response: {"message":"Bad credentials","documentation_url":"https://docs.github.com/rest","status":"401"})
```

### Repository Not Found
```
HTTP 404 for https://api.github.com/repos/user/repo/releases/latest: unexpected status code: 404
(response: {"message":"Not Found","documentation_url":"https://docs.github.com/rest/releases/releases#get-the-latest-release"})
```

## Creating Your Own Tap

To create your own Homebrew tap using this tool:

1. **Fork or copy this repository**
2. **Update `config.yaml`** with your repositories
3. **Create your custom README template** (see `readme.md.gotmpl` for reference)
4. **Set up GitHub token** in repository secrets as `GITHUB_TOKEN`
5. **Update the workflow** to use your template file
6. **Run the tool** manually or let GitHub Actions handle it

### Required Files

- `config.yaml` - Your repository configuration
- `readme.md.gotmpl` - Your custom README template
- `.github/workflows/trigger.yaml` - GitHub Actions workflow

For details about each app in this specific tap, please refer to their respective repositories.
