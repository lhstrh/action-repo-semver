# Repo SemVer

[![CI](https://github.com/lhstrh/greatest-semver-tag/actions/workflows/ci.yml/badge.svg)](https://github.com/lhstrh/greatest-semver-tag/actions/workflows/ci.yml)

This GitHub Action sorts through a given repository's tags and outputs the greatest according to the [rules of semantic versioning](https://semver.org/). In addition, it outputs "release", "major", "minor", "patch", "prerelease", and "build" increments. When given the version number of a release planned for the future, this action also reports whether it is indeed greater than the current version. This action is primarily intended as a utility for use in release automation workflows.

## Usage
In the `steps` of a job, specify the following:
```
- uses: lhstrh/action-repo-semver@v1.0.0
  id: repo-semver
  with:
    # Repository name with owner. For example, actions/checkout
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
    echo "The greatest tag is: ${{ steps.repo-semver.outputs.tag }}"
    echo "The current version is: ${{ steps.repo-semver.outputs.current }}"
    echo "The next major release is: ${{ steps.repo-semver.outputs.next-major }}"
```
Note that the `tag` output is "as-is", including any prefix the semver might have. All other outputs, including `current` and `next-*` are not prefixed _even if the tag has one_.


## Inputs

* `repo` If specified, this repository is checked out by the action. By default, no checkout occurs.
* `path` Location to find the repository checkout. By default, this is `$github.workspace`.
* `build` If specified, the `next-build` output will be generated featuring this string (and remain empty otherwise).
* `planned` If this is a valid semver greater than the `current` output, the `valid-planned` output is `true`.
*  `post-planned` If this is a valid semver greater than the `planned` input, the `valid-post-planned` output is `true`.


## Outputs

* `tag` The greatest tag found that qualifies as a semver string (or empty if none was found).
* `prefix` The prefix used in the found `tag` (or empty if none was used).
* `current` The version corresponding the the `tag` output, stripped of any prefix. Defaults to `0.0.0` if `tag` is empty. 
* `next-prerelease` The smallest prerelease increment relative to the `current` output.
* `next-patch` The smallest patch increment relative `current`.
* `next-minor` The smallest minor increment relative to `current`.
* `next-major` The smallest major increment relative to `current`.
* `next-release` The smallest release increment relative to `current`.
* `next-build` A build increment relative to `current`.
* `planned-is-valid` True if the `planned` input is a valid semver greater than the `current` output.
* `post-planned-is-valid` True if the `post-planned` input is a valid semver greater than `planned` input.


## Examples
* (prerelease) If `current` is `1.0.0`, then `next-prerelease` is `1.0.0-1`.
* (patch) If `current` is `1.0.0`, then `next-patch` is `1.0.1`.
* (minor) If `current` is `1.0.0`, then `next-minor` is `1.1.0`.
* (major) If `current` is `1.0.0`, then `next-major` is `2.0.0`.
* (release) If `current` is `1.0.0-beta`, then `next-release` is `1.0.0`.
* (build) If `current` is `1.0.0-beta` and the `build` input is `1`, then `next-build` is `1.0.0-beta+1`.


## Acknowledgement

This action makes use of the [semver shell utility](https://github.com/fsaintjacques/semver-tool) written by [François Saint-Jacques](https://github.com/fsaintjacques).
