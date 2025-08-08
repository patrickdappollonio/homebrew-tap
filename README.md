# Patrick's Homebrew Tap

This repo holds a collection of Homebrew formulae for my software projects and potentially other 3rd party applications that don't have a formula in the main Homebrew repository.

Any application from this page can be installed using:

```bash
brew install patrickdappollonio/tap/<application>
```

For instructions on how this repository works, please check [`USING.md`](./USING.md).

The list of available applications is:
* [`http-server`](#http-server)
* [`kubectl-slice`](#kubectl-slice)
* [`tgen`](#tgen)
* [`tabloid`](#tabloid)
* [`wait-for`](#wait-for)
* [`dotenv`](#dotenv)
* [`find-project`](#find-project)
* [`gc-rust`](#gc-rust)
* [`duality`](#duality)
* [`reverse-proxy-host`](#reverse-proxy-host)
* [`helm-list-charts`](#helm-list-charts)
* [`wiump`](#wiump)
* [`mcp-domaintools`](#mcp-domaintools)
* [`context-generator`](#context-generator)
* [`mcp-kubernetes-ro`](#mcp-kubernetes-ro)
* [`mockingjay`](#mockingjay)

## Applications

This is the list of available applications supported by this tap:

### `http-server`

<dl>
  <dt><strong>Description:</strong></dt>
  <dd>A small application with no dependencies to expose a local folder as an HTTP server. It includes a file explorer and a Markdown renderer.</dd>
  <dt><strong>License:</strong></dt>
  <dd>MIT</dd>
  <dt><strong>Repository:</strong></dt>
  <dd><a href="https://github.com/patrickdappollonio/http-server"><code>patrickdappollonio/http-server</code></a></dd>
</dl>

```bash
brew install patrickdappollonio/tap/http-server
```

### `kubectl-slice`

<dl>
  <dt><strong>Description:</strong></dt>
  <dd>Split multiple Kubernetes files into smaller files with ease. Split multi-YAML files into individual files.</dd>
  <dt><strong>License:</strong></dt>
  <dd>MIT</dd>
  <dt><strong>Repository:</strong></dt>
  <dd><a href="https://github.com/patrickdappollonio/kubectl-slice"><code>patrickdappollonio/kubectl-slice</code></a></dd>
</dl>

```bash
brew install patrickdappollonio/tap/kubectl-slice
```

### `tgen`

<dl>
  <dt><strong>Description:</strong></dt>
  <dd>A template tool with no dependencies that works like Helm templates or Consul templates.</dd>
  <dt><strong>License:</strong></dt>
  <dd>MIT</dd>
  <dt><strong>Repository:</strong></dt>
  <dd><a href="https://github.com/patrickdappollonio/tgen"><code>patrickdappollonio/tgen</code></a></dd>
</dl>

```bash
brew install patrickdappollonio/tap/tgen
```

### `tabloid`

<dl>
  <dt><strong>Description:</strong></dt>
  <dd>tabloid is a simple command line tool to parse and filter column-based CLI outputs from commands like kubectl or docker.</dd>
  <dt><strong>Repository:</strong></dt>
  <dd><a href="https://github.com/patrickdappollonio/tabloid"><code>patrickdappollonio/tabloid</code></a></dd>
</dl>

```bash
brew install patrickdappollonio/tap/tabloid
```

### `wait-for`

<dl>
  <dt><strong>Description:</strong></dt>
  <dd>A small, zero dependencies app that can be used as an init container to ping resources and check if they're available.</dd>
  <dt><strong>License:</strong></dt>
  <dd>MIT</dd>
  <dt><strong>Repository:</strong></dt>
  <dd><a href="https://github.com/patrickdappollonio/wait-for"><code>patrickdappollonio/wait-for</code></a></dd>
</dl>

```bash
brew install patrickdappollonio/tap/wait-for
```

### `dotenv`

<dl>
  <dt><strong>Description:</strong></dt>
  <dd>An app to call other apps using customized environment variables.</dd>
  <dt><strong>License:</strong></dt>
  <dd>MIT</dd>
  <dt><strong>Repository:</strong></dt>
  <dd><a href="https://github.com/patrickdappollonio/dotenv"><code>patrickdappollonio/dotenv</code></a></dd>
</dl>

```bash
brew install patrickdappollonio/tap/dotenv
```

### `find-project`

<dl>
  <dt><strong>Description:</strong></dt>
  <dd>Traverse through folders with ease!</dd>
  <dt><strong>License:</strong></dt>
  <dd>MIT</dd>
  <dt><strong>Repository:</strong></dt>
  <dd><a href="https://github.com/patrickdappollonio/find-project"><code>patrickdappollonio/find-project</code></a></dd>
</dl>

```bash
brew install patrickdappollonio/tap/find-project
```

### `gc-rust`

<dl>
  <dt><strong>Description:</strong></dt>
  <dd>Clone GitHub repositories like a champ!</dd>
  <dt><strong>Repository:</strong></dt>
  <dd><a href="https://github.com/patrickdappollonio/gc-rust"><code>patrickdappollonio/gc-rust</code></a></dd>
</dl>

> [!NOTE]
> If you want to use "gc-rust" simply as "gc", ensure you create a function or alias for it.
See https://github.com/patrickdappollonio/gc-rust#usage for instructions on how to do so.


```bash
brew install patrickdappollonio/tap/gc-rust
```

### `duality`

<dl>
  <dt><strong>Description:</strong></dt>
  <dd>Run multiple programs in parallel and wait for all to complete. A small command supervisor for your orchestration needs.</dd>
  <dt><strong>Repository:</strong></dt>
  <dd><a href="https://github.com/patrickdappollonio/duality"><code>patrickdappollonio/duality</code></a></dd>
</dl>

```bash
brew install patrickdappollonio/tap/duality
```

### `reverse-proxy-host`

<dl>
  <dt><strong>Description:</strong></dt>
  <dd>Reverse a connection from a local service with a custom Host header onto a new port.</dd>
  <dt><strong>Repository:</strong></dt>
  <dd><a href="https://github.com/patrickdappollonio/reverse-proxy-host"><code>patrickdappollonio/reverse-proxy-host</code></a></dd>
</dl>

```bash
brew install patrickdappollonio/tap/reverse-proxy-host
```

### `helm-list-charts`

<dl>
  <dt><strong>Description:</strong></dt>
  <dd>Navigate Helm chart indexes without adding them to your machine and with ease.</dd>
  <dt><strong>License:</strong></dt>
  <dd>MIT</dd>
  <dt><strong>Repository:</strong></dt>
  <dd><a href="https://github.com/patrickdappollonio/helm-list-charts"><code>patrickdappollonio/helm-list-charts</code></a></dd>
</dl>

```bash
brew install patrickdappollonio/tap/helm-list-charts
```

### `wiump`

<dl>
  <dt><strong>Description:</strong></dt>
  <dd>Who is using my port? A simple application to tell you what app is using your port.</dd>
  <dt><strong>License:</strong></dt>
  <dd>MIT</dd>
  <dt><strong>Repository:</strong></dt>
  <dd><a href="https://github.com/patrickdappollonio/wiump"><code>patrickdappollonio/wiump</code></a></dd>
</dl>

```bash
brew install patrickdappollonio/tap/wiump
```

### `mcp-domaintools`

<dl>
  <dt><strong>Description:</strong></dt>
  <dd>An MCP server via STDIO to query DNS and WHOIS information.</dd>
  <dt><strong>License:</strong></dt>
  <dd>MIT</dd>
  <dt><strong>Repository:</strong></dt>
  <dd><a href="https://github.com/patrickdappollonio/mcp-domaintools"><code>patrickdappollonio/mcp-domaintools</code></a></dd>
</dl>

```bash
brew install patrickdappollonio/tap/mcp-domaintools
```

### `context-generator`

<dl>
  <dt><strong>Description:</strong></dt>
  <dd>A fast, efficient command-line tool written in Rust that generates copy-pastable context from your source code, perfect for providing to AI assistants like ChatGPT, Claude, or Copilot.</dd>
  <dt><strong>License:</strong></dt>
  <dd>MIT</dd>
  <dt><strong>Repository:</strong></dt>
  <dd><a href="https://github.com/patrickdappollonio/context-generator"><code>patrickdappollonio/context-generator</code></a></dd>
</dl>

```bash
brew install patrickdappollonio/tap/context-generator
```

### `mcp-kubernetes-ro`

<dl>
  <dt><strong>Description:</strong></dt>
  <dd>An MCP server providing read-only access to Kubernetes clusters for AI assistants.</dd>
  <dt><strong>License:</strong></dt>
  <dd>MIT</dd>
  <dt><strong>Repository:</strong></dt>
  <dd><a href="https://github.com/patrickdappollonio/mcp-kubernetes-ro"><code>patrickdappollonio/mcp-kubernetes-ro</code></a></dd>
</dl>

```bash
brew install patrickdappollonio/tap/mcp-kubernetes-ro
```

### `mockingjay`

<dl>
  <dt><strong>Description:</strong></dt>
  <dd>A YAML-configurable HTTP server that uses Go templates to create dynamic mock APIs with regex routing, middleware support, and 100+ helper functions.</dd>
  <dt><strong>License:</strong></dt>
  <dd>MIT</dd>
  <dt><strong>Repository:</strong></dt>
  <dd><a href="https://github.com/patrickdappollonio/mockingjay"><code>patrickdappollonio/mockingjay</code></a></dd>
</dl>

```bash
brew install patrickdappollonio/tap/mockingjay
```
