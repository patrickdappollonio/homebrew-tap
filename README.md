# PatrickDappollonio Homebrew Tap

This repo holds a collection of Homebrew formulae for my software projects.

The configuration comes from the `config.yaml` file in this repository.

A configuration is defined as a list of repositories with the following settings:

```yaml
- name: example-app # binary name inside the compressed file
  repository: patrickdappollonio/example-app # GitHub repository
  description: "An example app" # description of the app
  test_command: "example-app --version" # command to test the installation, can be empty
  install_aliases: # list of aliases to install the app, can be empty
    - example
  rename_binary: fooexample # rename the binary to this name upon installation, can be empty
  conflicts_with: # list of homebrew formulae that conflict with this one, can be empty
    - name: example
      reason: 'Both install an "example" binary.'
```

For details about each app, please refer to their respective repository.
