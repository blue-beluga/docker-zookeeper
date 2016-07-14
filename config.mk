export GIT_REVISION=$(shell git rev-parse --short HEAD)

REGISTRY = docker.io
REPOSITORY = bluebeluga/zookeeper

PUSH_REGISTRIES = $(REGISTRY)
