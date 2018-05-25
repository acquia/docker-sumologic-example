DOCKER = docker
REPO = acquia/aws-syslog

TAG = $(shell git rev-parse --abbrev-ref HEAD 2>/dev/null)
ifeq ($(TAG), master)
	TAG = latest
else ifeq ($(TAG), HEAD)
	TAG = latest
endif

all: build

run: build
	$(DOCKER) run -d -p 8888 -e SUMO_ACCESS_ID=$(SUMO_ACCESS_ID) -e SUMO_ACCESS_KEY=$(SUMO_ACCESS_KEY) -e SUMO_COLLECTOR_NAME=$(SUMO_COLLECTOR_NAME) $(REPO)

buildpush:
	build
	push

build:
	$(DOCKER) build -t $(REPO):$(TAG) .

push:
	$(DOCKER) push acquia/aws-syslog:latest
