# Greatest SemVer Tag

[![CI](https://github.com/lhstrh/greatest-semver-tag/actions/workflows/ci.yml/badge.svg)](https://github.com/lhstrh/greatest-semver-tag/actions/workflows/ci.yml)

This action sorts through a given repository's tags and returns the greatest according to the [rules of semantic versioning](https://semver.org/).

## Usage
```
- uses: actions/greatest-semver-tag@v3
  with:
    # Repository name with owner. For example, actions/greatest-semver-tag
    # Default: ${{ github.repository }}
    repo: ''
```

## Acknowledgement

This action makes use of the [semver shell utility](https://github.com/fsaintjacques/semver-tool) written by [François Saint-Jacques](https://github.com/fsaintjacques).

