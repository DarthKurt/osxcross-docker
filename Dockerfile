# syntax=docker/dockerfile:1.14.0-labs

ARG TARGETARCH
ARG OSX_CROSS_COMMIT="593fe0260fc7fd4e4ed9462a516b4a5cd454c3ac"
ARG OSX_CROSS_BRANCH="2.0-llvm-based"
ARG DEB_VERSION="bookworm"

# Base Image
FROM debian:${DEB_VERSION}

# +-----------------------------+
# | REUSE GLOBAL ARGS           |
# +-----------------------------+

ARG TARGETARCH
ARG DEB_VERSION
ARG OSX_CROSS_COMMIT
ARG OSX_CROSS_BRANCH

# +-----------------------------+
# | PRE-REQUISITE/INIT PACKAGES |
# +-----------------------------+

RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
    locales  \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG="en_US.utf8"
ENV DEBIAN_FRONTEND="noninteractive"

# Install dependencies
RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
    gnupg2 \
    ca-certificates \
    software-properties-common \
    git \
    clang-19 \
    make \
    cmake \
    libssl-dev \
    libxml2-dev \
    lld-19 \
    tar \
    unzip \
    patch \
    xz-utils

# Clone osxcross to /workspace/osxcross as a shallow copy
RUN \
    git clone \
    --branch ${OSX_CROSS_BRANCH} \
    --single-branch \
    --depth 1 \
    "https://github.com/tpoechtrager/osxcross" "/osxcross" \
    && cd "/osxcross" \
    && git checkout ${OSX_CROSS_COMMIT}

# Set PATH for osxcross tools (populated after build)
ENV PATH="/usr/lib/llvm-19/bin:${PATH}"
ENV UNATTENDED=1

ENTRYPOINT ["/bin/bash"]
CMD ["/osxcross/build.sh"]
