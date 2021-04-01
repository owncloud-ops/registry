export BUILD_VERSION ?= 6affafd1

export BUILDTAGS ?= include_oss include_gcs
export GOOS ?= linux
export GOARCH ?= amd64

REGISTRY_REPO := https://github.com/distribution/distribution.git
REGISTRY_BRANCH := main
SRC := src

.PHONY: all
all: clean build

.PHONY: build
build: build-src build-bin

.PHONY: build-src
build-src:
	mkdir -p $(SRC); \
	git clone -b $(REGISTRY_BRANCH) $(REGISTRY_REPO) $(SRC) && \
	git -C $(SRC) checkout -q $${BUILD_VERSION}

.PHONY: build-bin
build-bin:
	cd $(SRC) && \
	CGO_ENABLED=0 make PREFIX=/go clean binaries

.PHONY: clean
clean:
	rm -rf $(SRC)
