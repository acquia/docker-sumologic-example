DOCKER = docker
REPO = nickveenhof/aws-syslog

TAG = $(shell git rev-parse --abbrev-ref HEAD 2>/dev/null)
ifeq ($(TAG), master)
	TAG = latest
else ifeq ($(TAG), HEAD)
	TAG = latest
endif

all: build

run: build
	$(DOCKER) run -i -t $(shell cat .dockeropts) $(REPO)

build:
	$(DOCKER) build -t $(REPO):$(TAG) .
	$(DOCKER) tag -f 2ad2f5b6d0b1 nickveenhof/aws-syslog:latest
	$(DOCKER) push nickveenhof/aws-syslog:latest
