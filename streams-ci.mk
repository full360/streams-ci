# This make file is intended for an override for streams
# Check if there is only one directory/group, assume that is the stream name
# or if there are more than one, then the stream name needs to be specified


DOCKERMK := $(shell if [ ! -e docker-ci.mk ]; then \
                    wget -N -q https://raw.githubusercontent.com/full360/docker-ci/master/docker-ci.mk; fi)
include docker-ci.mk

getstreams:
ifeq "$(words $(GROUPS))" "1"
BUILDARGS = "STREAM_NAME=$(firstword $(GROUPS))"
STREAM_NAME = $(firstword $(GROUPS))
CONTAINER_NAME = $(firstword $(GROUPS))
else
ifndef STREAM_NAME
$(warning You must specify the stream name you are building if there are multiple streams)
$(warning e.g. STREAM_NAME=somestream make build)
BUILDARGS = "STREAM_NAME=$(STREAM_NAME)"
CONTAINER_NAME = $STREAM_NAME
endif
endif

# override the targets (so it only builds the particular stream)
# with this override, docker-ci.mk does not have to change for this
# stream specific functionality
build: ;

tag: ;

push: ;

build: build-$(STREAM_NAME) getstreams

tag: tag-$(STREAM_NAME) getstreams

push: push-$(STREAM_NAME) getstreams
