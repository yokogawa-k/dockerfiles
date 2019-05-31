SHELL := /bin/bash

IMAGE := yokogawa/awspec
DOCKER_OPT := -it --rm -v $${PWD}:/work

.PHONY: default help init spec test shell
default: help

help:
	docker run $(DOCKER_OPT) $(IMAGE) awspec --help

init:
	docker run --user $(id -u):$(id -g) $(DOCKER_OPT) $(IMAGE) awspec init

spec: test

test:
	docker run $(DOCKER_OPT) -v $${HOME}/.aws/:/root/.aws/ -e AWS_PROFILE $(IMAGE) rake spec

shell:
	docker run $(DOCKER_OPT) -v $${HOME}/.aws/:/root/.aws/ -e AWS_PROFILE --entrypoint=sh $(IMAGE)
