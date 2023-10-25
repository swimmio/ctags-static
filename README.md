# ctags-static
Static builds of [universal-ctags](https://github.com/universal-ctags/ctags)

Note: Currently pinned to a specific version as we encountered some bug in the latest version, we will update to the latest once we solve those.

## Dependencies
### macOS
* Xcode Command Line Tools
* autoconf
* automake
* docutils

### Linux
* build-essential
* musl-tools
* docutils

### Windows
See https://github.com/universal-ctags/ctags/blob/master/docs/windows.rst#gcc-1

## TODO
* macOS min target version
* Is ICU4C needed for the Linux build?
