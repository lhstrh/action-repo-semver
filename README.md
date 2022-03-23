# SemVer Tag

[![CI](https://github.com/lhstrh/greatest-semver-tag/actions/workflows/ci.yml/badge.svg)](https://github.com/lhstrh/greatest-semver-tag/actions/workflows/ci.yml)

This action sorts through a given repository's tags and outputs the greatest according to the [rules of semantic versioning](https://semver.org/). In addition, it outputs "release", "major", "minor", "patch", "prerelease", and "build" increments. When given the version number of a release planned for the future, this action also reports whether it is indeed greater than the current version.

## Usage
In the `steps` of a job, specify the following:
```
- uses: actions/greatest-semver-tag@v1.0.0-beta.0
  id: semver-tag
  with:
    # Repository name with owner. For example, actions/greatest-semver-tag
    # Default: ${{ github.repository }}
    repo: ''
    # Path to find/store the repository checkout
    # Default: ${{ github.workspace }}
    path: ''
    # String to be used in next-build output
    # Default: ''
    build: ''
    # Version of planned release
    # Default: ''
    planned: ''
    # Version after planned release
    # Default: ''
    post-planned: ''
```
You can then use the output in a subsequent step:
```
- name: Do something with the found tag
  run: |
    echo "The greatest tag is: ${{ steps.semver-tag.outputs.tag }}"
    echo "The current version is: ${{ steps.semver-tag.outputs.current }}"
    echo "The next major release is: ${{ steps.semver-tag.outputs.next-major }}"
```
Note that the `tag` output is "as-is", including any prefix the semver might have. All other outputs, including `current` and `next-*` are not prefixed _even if the tag has one_.

## Inputs

### `repo`
If specified, this repository is checked out by the action. By default, no checkout occurs.

### `path`
Location to find the repository checkout. By default, this is `$github.workspace`.

### `build`
If specified, the `next-build` output will be generated featuring this string. If not specified, the `next-build` output will remain empty.

### `planned`
If the given string is a valid semver greater than the `current` output, the `valid-planned` output evaluates to `true`.

### `post-planned`
If the given string is a valid semver greater than the `planned` input, the `valid-post-planned` output evaluates to `true`.

## Outputs
### `tag`
### `current`
Defaults to `0.0.0` if no semver tag was found. 
### `next-prerelease`
### `next-patch`
### `next-minor`
### `next-major`
### `next-release`
### `next-build`
### `planned-is-valid`
### `post-planned-is-valid`


## Acknowledgement

This action makes use of the [semver shell utility](https://github.com/fsaintjacques/semver-tool) written by [François Saint-Jacques](https://github.com/fsaintjacques).
