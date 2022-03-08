# renovate: datasource=github-tags depName=distribution/distribution
export BUILD_VERSION ?= v2.8.1

export BUILDTAGS ?= include_oss include_gcs
export GOOS ?= linux
export GOARCH ?= amd64

ROOTDIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
REGISTRY_REPO := https://github.com/distribution/distribution
REGISTRY_BRANCH := main
SRC := src
BUILD := $(SRC)/github.com/docker/distribution

.PHONY: all
all: clean build

.PHONY: build
build: build-src build-bin build-final

.PHONY: build-src
build-src:
	mkdir -p $(BUILD); \
	git clone -b $(REGISTRY_BRANCH) $(REGISTRY_REPO) $(BUILD) && \
	git -C $(BUILD) checkout -q $${BUILD_VERSION}

.PHONY: build-bin
build-bin:
	cd $(BUILD) && \
	GO111MODULE=off GOPATH=$(ROOTDIR) CGO_ENABLED=0 make PREFIX=/go clean binaries

.PHONY: build-final
build-final:
	mv $(BUILD)/bin $(SRC)

.PHONY: clean
clean:
	rm -rf $(SRC)
