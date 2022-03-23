# SemVer Tag

[![CI](https://github.com/lhstrh/greatest-semver-tag/actions/workflows/ci.yml/badge.svg)](https://github.com/lhstrh/greatest-semver-tag/actions/workflows/ci.yml)

This action sorts through a given repository's tags and outputs the greatest according to the [rules of semantic versioning](https://semver.org/). (It outputs `0.0.0` if no semver tag was found.) In addition, it outputs "release", "major", "minor", "patch", "prerelease", and "build" increments. When given the version number of a release planned for the future, this action also reports whether it is indeed greater than the current version.

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
    planned: ''
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

## Acknowledgement

This action makes use of the [semver shell utility](https://github.com/fsaintjacques/semver-tool) written by [François Saint-Jacques](https://github.com/fsaintjacques).
