FROM docker.io/amd64/alpine:3.19@sha256:6457d53fb065d6f250e1504b9bc42d5b6c65941d57532c072d929dd0628977d0

LABEL maintainer="ownCloud GmbH"
LABEL org.opencontainers.image.authors="ownCloud GmbH"
LABEL org.opencontainers.image.title="Docker Registry"
LABEL org.opencontainers.image.url="https://github.com/owncloud-ops/registry"
LABEL org.opencontainers.image.source="https://github.com/owncloud-ops/registry"
LABEL org.opencontainers.image.documentation="https://github.com/owncloud-ops/registry"

ARG CONTAINER_LIBRARY_VERSION

# renovate: datasource=github-releases depName=owncloud-ops/container-library
ENV CONTAINER_LIBRARY_VERSION="${CONTAINER_LIBRARY_VERSION:-v0.1.0}"

ADD overlay/ /
ADD src/bin/registry /bin/registry

RUN addgroup -g 1001 -S app && \
    adduser -S -D -H -u 1001 -h /home/app -s /bin/sh -G app -g app app

RUN apk --update add --virtual .build-deps curl tar && \
    apk add --no-cache ca-certificates && \
    apk upgrade --no-cache libcrypto3 libssl3 && \
    curl -SsfL "https://github.com/owncloud-ops/container-library/releases/download/${CONTAINER_LIBRARY_VERSION}/container-library.tar.gz" | tar xz -C / && \
    apk del .build-deps && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

VOLUME /var/lib/registry

EXPOSE 5000

USER app

ENTRYPOINT ["/usr/bin/entrypoint"]
HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD /usr/bin/healthcheck
WORKDIR /var/lib/registry
CMD []
