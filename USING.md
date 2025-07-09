# PatrickDappollonio Homebrew Tap

This repository uses a tiny Go application that converts the repositories listed in [`config.yaml`](config.yaml) into Homebrew formulae.

This process runs daily using GitHub Actions, although it can also be triggered using a `workflow_dispatch`. The generated formulae are then pushed to the `Formula` directory in this repository and the `README.md` file is updated to reflect all available applications.

## How It Works

The application automatically detects the latest, non-draft, published version of the repository listed in the configuration file. It then generates a formula file with the necessary information to install the binary.

### Features

- **Automatic Release Detection**: Fetches the latest non-draft, published releases from GitHub
- **Multi-Platform Support**: Generates formulas for macOS (Intel/ARM64) and Linux (Intel/ARM64/ARM)
- **Intelligent Caching**: Uses asset ID-based caching to avoid unnecessary downloads when GitHub release assets haven't changed
- **Deterministic Output**: Ensures consistent formula generation with platform-specific architecture priorities:
  - **macOS**: ARM64 first, then Intel, then ARM
  - **Linux**: Intel first, then ARM64, then ARM
- **Smart File Writing**: Only writes formula files when content has actually changed, preserving timestamps
- **Architecture Deduplication**: Automatically removes duplicate downloads for the same architecture, preferring LIBC over MUSL builds
- **Custom README Templates**: Allows users to provide their own README template with rich templating functions
- **SPDX License Validation**: Validates license fields against the official SPDX license list
- **Orphaned Formula Cleanup**: Optionally removes formula files that no longer correspond to apps in the config
- **Enhanced Error Handling**: Provides detailed error messages with HTTP status codes and response bodies
- **Flexible Configuration**: Supports aliases, binary renaming, conflicts, caveats, and more

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
- `--cleanup-orphaned`: Remove formula files that no longer correspond to apps in the config (default: `false`)

### Environment Variables

- `GITHUB_TOKEN`: GitHub personal access token for API requests (recommended for higher rate limits)

### Caching Mechanism

The tool uses an intelligent caching system to improve performance:

- **Asset ID-Based Caching**: Caches GitHub release asset information using asset IDs rather than filenames
- **Cache Storage**: Cache data is embedded as JSON comments in the generated formula files
- **Cache Validation**: Automatically detects when GitHub release assets have changed and invalidates cache
- **Performance Benefits**: Avoids re-downloading and re-calculating SHA256 hashes for unchanged assets
- **Transparency**: Cache information is visible in the generated formula files for debugging

Example cache comment in a formula file:
```ruby
# TAPGEN_CACHE: {"tag":"v1.0.0","repository":"user/repo","cached_at":"2024-01-01T00:00:00Z","assets":[...]}
```

### Architecture Prioritization

The tool generates formulas with deterministic, platform-optimized architecture ordering:

#### Download Sorting Order:
1. **macOS downloads** (processed first)
   - ARM64 architectures first
   - Intel architectures second
2. **Linux downloads** (processed after macOS)
   - Intel architectures first
   - ARM64 architectures second
   - General ARM architectures last

#### Architecture Detection:
- **Intel**: Detects `amd64`, `x86_64`, `86_64` patterns
- **ARM64**: Detects `arm64` patterns
- **ARM**: Detects `arm` patterns (non-64bit)

#### Deduplication:
- Automatically removes duplicate downloads for the same architecture
- Prefers LIBC builds over MUSL builds when both are available
- Ensures each architecture has only one download entry in the formula

This ensures consistent, predictable formula generation and eliminates random ordering changes in generated files.

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
- `lowerAlphaNum`: Normalize string to lowercase alphanumeric characters only
- `classify`: Convert to PascalCase (used for Ruby class names)
- `now`: Current timestamp in RFC850 format
- `indent`, `nindent`: Text indentation helpers
- `stringsJoin`: Join string arrays with separator

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

| Field             | Type   | Required | Description                                                    |
| ----------------- | ------ | -------- | -------------------------------------------------------------- |
| `name`            | string | ✅        | Binary name and formula identifier                             |
| `repository`      | string | ✅        | GitHub repository in `owner/repo` format                       |
| `description`     | string | ✅        | Short description of the application                           |
| `url`             | string | ❌        | Homepage URL (defaults to GitHub repository)                   |
| `test_command`    | string | ❌        | Command to test the installation                               |
| `license`         | string | ❌        | SPDX license identifier (validated against official SPDX list) |
| `install_aliases` | array  | ❌        | List of additional command aliases                             |
| `rename_binary`   | string | ❌        | Rename the binary upon installation                            |
| `conflicts_with`  | array  | ❌        | List of conflicting Homebrew formulae                          |
| `caveats`         | string | ❌        | Additional installation notes                                  |

### License Validation

The tool validates license fields against the official SPDX license list to ensure compatibility with Homebrew requirements:

- **Automatic Validation**: All license fields are checked during config parsing
- **SPDX Compliance**: Uses the official SPDX license identifiers (version 3.26.0 as of 2024-12-30)
- **Error Prevention**: Invalid licenses cause the tool to exit with a helpful error message
- **Common Licenses**: Supports popular licenses like `MIT`, `Apache-2.0`, `BSD-3-Clause`, `GPL-3.0-only`, etc.

Example error for invalid license:
```
failed to validate license for "my-app": license "InvalidLicense" is not a valid SPDX license, see list at: https://spdx.org/licenses/
```

## GitHub Actions Integration

The repository uses GitHub Actions to automatically update formulas. The workflow:

1. Runs daily at midnight
2. Can be triggered manually with `workflow_dispatch`
3. Downloads the latest binary release
4. Generates formulas for all configured repositories (only updating changed files)
5. Automatically removes formula files for apps no longer in the configuration
6. Updates the README using the template
7. Commits and pushes changes

The application uses intelligent caching and file comparison to only update files when necessary, making the process efficient and preserving manual changes when possible.

### Workflow Configuration

The GitHub Actions workflow supports the following inputs:

- `target`: (Optional) The specific repository to update instead of processing all configurations
- `cleanup_orphaned`: (Optional) Whether to remove formula files that no longer correspond to apps in the config (default: `false`)

### Orphaned Formula Cleanup

The `--cleanup-orphaned` flag enables automatic cleanup of formula files that no longer correspond to applications in your configuration:

- **Safe by Default**: Disabled by default to prevent accidental deletion
- **Selective Cleanup**: Only removes `.rb` files from the `Formula/` directory
- **Config-Based**: Compares existing formula files against the `name` field in your config
- **Logging**: Provides clear logs about which files are being removed

This feature is useful when you remove applications from your config and want to automatically clean up the corresponding formula files.

```yaml
- name: Run application to generate Formulas
  run: |
    rm -f README.md
    homebrew-tap --target "${{ github.event.inputs.target }}" ${{ github.event.inputs.cleanup_orphaned == 'true' && '--cleanup-orphaned' || '' }}
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

*Note: The workflow only removes README.md and lets the application handle formula file management intelligently. When `cleanup_orphaned` is enabled, it will remove formula files for apps no longer in the configuration, but this is disabled by default to prevent accidental deletion.*

### Smart File Management

The tool implements intelligent file management to minimize unnecessary changes:

- **Content Comparison**: Only writes formula files when content has actually changed
- **Timestamp Preservation**: Unchanged files maintain their original modification times
- **Minimal Git Changes**: Reduces noise in git history by avoiding unnecessary commits
- **Performance**: Faster execution when most formulas are already up to date

Example log output:
```
Formula file "Formula/my-app.rb" is up to date, skipping...
Formula file "Formula/other-app.rb" generated successfully
```

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
