FROM alpine:3.14@sha256:234cb88d3020898631af0ccbbcca9a66ae7306ecd30c9720690858c1b007d2a0

LABEL maintainer="ownCloud GmbH"
LABEL org.opencontainers.image.authors="ownCloud GmbH"
LABEL org.opencontainers.image.title="Docker Registry"
LABEL org.opencontainers.image.url="https://github.com/owncloud-ops/registry"
LABEL org.opencontainers.image.source="https://github.com/owncloud-ops/registry"
LABEL org.opencontainers.image.documentation="https://github.com/owncloud-ops/registry"

ADD overlay/ /
ADD src/bin/registry /bin/registry

RUN addgroup -g 1001 -S app && \
    adduser -S -D -H -u 1001 -h /home/app -s /bin/sh -G app -g app app

RUN apk add --no-cache ca-certificates && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

VOLUME /var/lib/registry

EXPOSE 5000

USER app

ENTRYPOINT ["/usr/bin/entrypoint"]
HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD /usr/bin/healthcheck
WORKDIR /var/lib/registry
CMD []
