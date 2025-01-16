# PatrickDappollonio Homebrew Tap

This repo holds a collection of Homebrew formulae for my software projects and potentially some projects I find noteworthy.

### How do I install these formulae?

Just `brew tap patrickdappollonio/tap` and then `brew install <formula>`.

A short convenience version can also be used with:

```bash
brew install patrickdappollonio/tap/<formula>
```

The currently available formulae are in the [Formula](Formula/) directory.

If you're curious, most of my currently maintained repositories are offered here as a tap download. You can find any of my repos in [my GitHub profile](https://www.github.com/patrickdappollonio).

### How does this work?

This repository uses a tiny Go application that converts the repositories listed in [`config.yaml`](config.yaml) into Homebrew formulae.

This process runs every 4 hours automatically using GitHub Actions. The generated formulae are then pushed to the `Formula` directory in this repository.

The application automatically detects the latest, non-draft, published version of the repository listed in the configuration file. It then generates a formula file with the necessary information to install the binary.

A configuration is defined as a list of repositories with the following settings:

```yaml
- name: example-app # binary name inside the compressed file
  repository: patrickdappollonio/example-app # GitHub repository
  description: "An example app" # description of the app
  test_command: "example-app --version" # command to test the installation, can be empty
  license: MIT # license of the app
  install_aliases: # list of aliases to install the app, can be empty
    - example
  rename_binary: fooexample # rename the binary to this name upon installation, can be empty
  conflicts_with: # list of homebrew formulae that conflict with this one, can be empty
    - name: example
      reason: 'Both install an "example" binary.'
  caveats: |-
    This is a caveat for the example app.
    It can be multiline.
```

For details about each app, please refer to their respective repository.
