export BUILD_VERSION ?= release/2.7

export BUILDTAGS ?= include_oss include_gcs
export GOOS ?= linux
export GOARCH ?= amd64

ROOTDIR=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
REGISTRY_REPO := https://github.com/distribution/distribution.git
REGISTRY_BRANCH := main
SRC := build/src/github.com/docker/distribution

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
	go env && \
	GO111MODULE=on GOPATH=$(ROOTDIR)build CGO_ENABLED=0 make PREFIX=/go clean binaries

.PHONY: clean
clean:
	rm -rf $(SRC)
