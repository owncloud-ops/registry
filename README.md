# registry

[![Build Status](https://drone.owncloud.com/api/badges/owncloud-ops/registry/status.svg)](https://drone.owncloud.com/owncloud-ops/registry/)
[![Docker Hub](https://img.shields.io/badge/docker-latest-blue.svg?logo=docker&logoColor=white)](https://hub.docker.com/r/owncloudops/registry)

Custom container image for the [Container Registry](https://github.com/distribution/distribution).

## Ports

- 5000

## Volumes

- /var/lib/registry

## Environment Variables

See [registry/configuration](https://docs.docker.com/registry/configuration/#override-specific-configuration-options) for configuration options.

## Build

```Shell
docker build -f Dockerfile -t registry:latest .
```

## License

This project is licensed under the Apache 2.0 License - see the [LICENSE](https://github.com/owncloud-ops/registry/blob/main/LICENSE) file for details.
