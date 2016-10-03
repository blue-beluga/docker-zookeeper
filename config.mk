# encoding: UTF-8

GIT_REVISION=$(shell git rev-parse --short HEAD)

REGISTRY = docker.io
FROM = bluebeluga/alpine
REPOSITORY = bluebeluga/zookeeper

PUSH_REGISTRIES = $(REGISTRY)
