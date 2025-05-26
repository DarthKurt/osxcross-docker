# osxcross-docker

A Dockerized wrapper for [osxcross](https://github.com/tpoechtrager/osxcross).

## About

This project packages the [osxcross](https://github.com/tpoechtrager/osxcross) toolchain into a Docker container, simplifying the process of building and using macOS cross-compilers on non-macOS systems.
All credits for the toolchain itself go to the original osxcross project.

## HOWTO

```sh

docker run \
  -v path/to/MacOSXxxx.sdk.tar.xz:/osxcross/tarballs/MacOSXxxx.sdk.tar.xz \
  -v path/to/osxcross-toolchain:/osxcross/target \
  --rm \
  osxcross-builder

```

For example:

```sh

docker run \
  -e UNATTENDED='true' \
  -v ${HOME}/SDKs/MacOSX15.4.sdk.tar.xz:/osxcross/tarballs/MacOSX15.4.sdk.tar.xz \
  -v ${HOME}/SDKs/osxcross-osx-15.4:/osxcross/target \
  --rm \
  osxcross-builder

```
