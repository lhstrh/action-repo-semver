# GitHub Action: Repo SemVer

[![CI](https://github.com/lhstrh/greatest-semver-tag/actions/workflows/ci.yml/badge.svg)](https://github.com/lhstrh/greatest-semver-tag/actions/workflows/ci.yml)

This GitHub Action sorts through a given repository's tags and returns the greatest according to the [rules of semantic versioning](https://semver.org/) on its `tag` output, along with a clean semver stripped of any prefix on its `current` output. This action is primarily intended as a utility for use in release automation workflows.

**Obtaining version increments**

The `next-*` outputs yield a semver that has a corresponding increment over the `current` output (e.g., if `current` is `1.0.0` then `next-minor` is `1.0.1`).

**Requesting a specific version bump**

If a `bump` input is given (e.g., "minor" or "release"), the `bump` output yields the requested semver with respect to `current`.

**Validating planned a version**

When given a semver on the `planned` input, this action reports whether the given version is indeed greater than `current` on the `planned-is-valid` output. 

## Usage
In the `steps` of a job, specify the following:
```
- name: Repo SemVer
  uses: lhstrh/action-repo-semver@v1.1.2
  id: repo-semver
  with:
    bump: patch
```
You can then use the output in a subsequent step:
```
- name: Do something with the found tag
  run: |
    echo "The greatest tag is: ${{ steps.repo-semver.outputs.tag }}"
    echo "The current version is: ${{ steps.repo-semver.outputs.current }}"
    echo "The next major release is: ${{ steps.repo-semver.outputs.next-major }}"
    echo "The requested bump is: ${{ steps.repo-semver.outputs.bump }}"
```
Assuming the greatest tag is `v3.14.0`, this will give the following output:
```
The greatest tag is: v3.14.0
The current version is: 3.14.0
The next major release is: 4.0.0
The requested bump is: 3.14.1
```

Note that the `tag` output is "as-is", including any prefix the semver might have. All other outputs, including `current`, `bump`, and `next-*` are not prefixed _even if the tag has one_.


## Inputs (all are _optional_)

* `repo` If specified, this repository is checked out by the action. By default, no checkout occurs.
* `path` Location to find the repository checkout. By default, this is `$github.workspace`.
* `bump` If specified, the `bump` output will reflect the given version increment with respect to `current`.
* `planned` If this is a valid semver greater than the `current` output, the `valid-planned` output is `true`.
* `build` If specified, the `next-build` output will be generated featuring this string (and remain empty otherwise).
* `prerelease` If specified, the `next-prerelease` output will be generated featuring this string (and remain empty otherwise).


## Outputs

* `tag` The greatest tag found that qualifies as a semver string (or empty if none was found).
* `prefix` The prefix used in the found `tag` (or empty if none was used).
* `current` The version corresponding the the `tag` output, stripped of any prefix. Defaults to `0.0.0` if `tag` is empty. 
* `bump` The version increment relative to `current` as specified in the `bump` input (or empty if none was given).
* `next-prerelease` The smallest prerelease increment relative to the `current` output.
* `next-patch` The smallest patch increment relative `current`.
* `next-minor` The smallest minor increment relative to `current`.
* `next-major` The smallest major increment relative to `current`.
* `next-release` The smallest release increment relative to `current`.
* `next-build` A build increment relative to `current`.
* `planned-is-valid` True if the `planned` input is a valid semver greater than the `current` output.

## Examples
* (prerelease) If `current` is `1.0.0`, then `next-prerelease` is `1.0.0-1`.
* (patch) If `current` is `1.0.0`, then `next-patch` is `1.0.1`.
* (minor) If `current` is `1.0.0`, then `next-minor` is `1.1.0`.
* (major) If `current` is `1.0.0`, then `next-major` is `2.0.0`.
* (release) If `current` is `1.0.0-beta`, then `next-release` is `1.0.0`.
* (build) If `current` is `1.0.0-beta` and the `build` input is `1`, then `next-build` is `1.0.0-beta+1`.


## Acknowledgement

This action makes use of the [semver shell utility](https://github.com/fsaintjacques/semver-tool) written by [François Saint-Jacques](https://github.com/fsaintjacques).
