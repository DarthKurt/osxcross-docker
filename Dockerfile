# syntax=docker.io/docker/dockerfile:1.14.0-labs

ARG TARGETARCH
ARG BUILD_DATE
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG IMAGE_URL
ARG IMAGE_VENDOR
ARG IMAGE_DESCRIPTION
ARG IMAGE_TITLE
ARG LICENSE

ARG OSX_CROSS_REPO="https://github.com/tpoechtrager/osxcross"
ARG OSX_CROSS_COMMIT="593fe0260fc7fd4e4ed9462a516b4a5cd454c3ac"
ARG OSX_CROSS_BRANCH="2.0-llvm-based"

ARG BASE_IMAGE="docker.io/debian"
ARG BASE_IMAGE_VARIANT="bookworm"

FROM ${BASE_IMAGE}:${BASE_IMAGE_VARIANT}

# +-----------------------------+
# | REUSE GLOBAL ARGS           |
# +-----------------------------+

ARG TARGETARCH
ARG BUILD_DATE
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG IMAGE_URL
ARG IMAGE_VENDOR
ARG IMAGE_DESCRIPTION
ARG IMAGE_TITLE
ARG LICENSE

ARG BASE_IMAGE
ARG BASE_IMAGE_VARIANT
ARG OSX_CROSS_REPO
ARG OSX_CROSS_COMMIT
ARG OSX_CROSS_BRANCH

# +-----------------------------+
# | Labels                      |
# +-----------------------------+

LABEL org.opencontainers.image.base.name=${BASE_IMAGE}:${BASE_IMAGE_VARIANT}
LABEL org.opencontainers.image.created=${BUILD_DATE}
LABEL org.opencontainers.image.version=${VERSION}
LABEL org.opencontainers.image.source=${VCS_URL}
LABEL org.opencontainers.image.revision=${VCS_REF}
LABEL org.opencontainers.image.url=${IMAGE_URL}
LABEL org.opencontainers.image.description=${IMAGE_DESCRIPTION}
LABEL org.opencontainers.image.title=${IMAGE_TITLE}
LABEL org.opencontainers.image.vendor=${IMAGE_VENDOR}
LABEL org.opencontainers.image.licenses=${LICENSE}

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

# +-----------------------------+
# | OSXCross                    |
# +-----------------------------+

## Clone osxcross to /workspace/osxcross as a shallow copy
RUN \
    git clone \
    --branch ${OSX_CROSS_BRANCH} \
    --single-branch \
    --depth 1 \
    ${OSX_CROSS_REPO} "/osxcross" \
    && cd "/osxcross" \
    && git checkout ${OSX_CROSS_COMMIT}

ENV PATH="/usr/lib/llvm-19/bin:${PATH}"
ENV UNATTENDED=1

ENTRYPOINT ["/bin/bash"]
CMD ["/osxcross/build.sh"]
