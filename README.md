# GitHub Action for FAKE

This Action wraps the FAKE CLI to enable common [FAKE](https://fake.build/) commands.

#### Example `.github/main.workflow`:

```hcl
workflow "Example workflow" {
  on = "push"
  resolves = ["Run a FAKE target"]
}

action "Run a FAKE target" {
  uses = "awseward/gh-action-fake5@master"
  args = ["some_target"]
}
```

The above workflow will run the following FAKE call in a GitHub Action:

```sh
fake build -t some_target
```
