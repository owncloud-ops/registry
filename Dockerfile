FROM alpine:3.14@sha256:635f0aa53d99017b38d1a0aa5b2082f7812b03e3cdb299103fe77b5c8a07f1d2

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
