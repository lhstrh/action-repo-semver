# Greatest SemVer Tag

[![CI](https://github.com/lhstrh/greatest-semver-tag/actions/workflows/ci.yml/badge.svg)](https://github.com/lhstrh/greatest-semver-tag/actions/workflows/ci.yml)

This action sorts through a given repository's tags and returns the greatest according to the [rules of semantic versioning](https://semver.org/).

## Usage
In the `steps` of a job, specify the following:
```
- uses: actions/greatest-semver-tag@v1.0.0-beta.0
  id: greatest
  with:
    # Repository name with owner. For example, actions/greatest-semver-tag
    # Default: ${{ github.repository }}
    repo: ''
```
You can then use the output in a subsequent step:
```
- name: Do something with the greatest tag
  run: |
    echo "The greatest tag is: ${{ steps.greatest.outputs.tag }}"
```
If your version tags start with a leading `v` and you would like to extract the numerical part of the tag, simply use the `no-prefix` output:
```
- name: Do something with the numerical part of the greatest tag
  run: |
    echo "The greatest tag sans leading 'v': ${{ steps.greatest.outputs.no-prefix }}"
```

## Acknowledgement

This action makes use of the [semver shell utility](https://github.com/fsaintjacques/semver-tool) written by [François Saint-Jacques](https://github.com/fsaintjacques).
