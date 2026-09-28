
# pre-commit (pre-commit)

Install the pre-commit framework to manage pre-commit hooks.

## Example Usage

```json
"features": {
    "ghcr.io/doughom/features/pre-commit:4": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Version of pre-commit to install. | string | 4.6.2 |

## Additional Configuration

Run `pre-commit install --install-hooks` with `postStartCommand` in your `devcontainer.json`.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/doughom/features/blob/main/src/pre-commit/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
