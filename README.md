# OSXCross Docker

[![Docker Image CI](https://github.com/DarthKurt/osxcross-docker/actions/workflows/docker-image.yml/badge.svg)](https://github.com/DarthKurt/osxcross-docker/actions/workflows/docker-image.yml)

A Dockerized wrapper for [osxcross](https://github.com/tpoechtrager/osxcross).

## About

This project packages the [osxcross](https://github.com/tpoechtrager/osxcross) toolchain into a Docker container.

It streamlines the setup of macOS cross-compilers on non-macOS systems by abstracting environment configuration and dependency management.

**[Please ensure you have read and understood the Xcode license terms before continuing.](https://www.apple.com/legal/sla/docs/xcode.pdf)**

To use the container, supply a valid [packaged macOS SDK tarball](https://github.com/tpoechtrager/osxcross#packaging-the-sdk) and mount a directory where the toolchain should be installed.

All credits for the toolchain itself go to the original [osxcross](https://github.com/tpoechtrager/osxcross) project.

## How to use

```sh

docker run \
  -v path/to/MacOSXxxx.sdk.tar.xz:/osxcross/tarballs/MacOSXxxx.sdk.tar.xz \
  -v path/to/osxcross-toolchain:/osxcross/target \
  --rm \
  darthkurt/osxcross-builder:latest

```

For example:

```sh

docker run \
  -v ${HOME}/SDKs/MacOSX15.4.sdk.tar.xz:/osxcross/tarballs/MacOSX15.4.sdk.tar.xz \
  -v ${HOME}/SDKs/osxcross-osx-15.4:/osxcross/target \
  --rm \
  darthkurt/osxcross-builder:latest

```
