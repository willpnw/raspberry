CONTAINER_DATA_DIR ?= $(CURDIR)/data
CONTAINER_IMAGE_NAME ?= 70caf31b
CONTAINER_VOLUME_HOME ?= $(CONTAINER_IMAGE_NAME)-home

container-inspect-cmd := docker inspect --type=image $(CONTAINER_IMAGE_NAME)

makefile-container-required = 0

ifneq ($(filter docker, $(MAKECMDGOALS)),)
    makefile-container-required = 1
endif

ifeq ($(makefile-container-required),1)
ifneq ($(shell $(container-inspect-cmd) 1>/dev/null 2>&1; echo $$?), 0)
    $(error Error while trying to inspect container image: $(CONTAINER_IMAGE_NAME))
endif
endif

dockerfile: Dockerfile
	@docker build \
		--build-arg GID=$(shell id -g) \
		--build-arg HOME=$(HOME) \
		--build-arg UID=$(shell id -u) \
		--build-arg USER=$(shell id -un) \
		--force-rm \
		--tag $(CONTAINER_IMAGE_NAME) \
                .

docker: $(DATA_DIR)
	@docker run --interactive --rm --tty --name $(CONTAINER_IMAGE_NAME) \
		$(foreach id,$(shell id -G), --group-add $(id)) \
		--env SSH_AUTH_SOCK=/run/ssh-agent \
		--user $(shell id -un) \
		--volume $(CONTAINER_VOLUME_HOME):$(HOME) \
		--volume $(abspath $(CONTAINER_DATA_DIR)):$(abspath $(CONTAINER_DATA_DIR)) \
		--volume $(shell readlink -f $(SSH_AUTH_SOCK)):/run/ssh-agent \
		--workdir $(abspath $(CONTAINER_DATA_DIR)) \
		$(CONTAINER_IMAGE_NAME) \
		$(CONTAINER_ARGS)

distclean:
	@docker rmi $(CONTAINER_IMAGE_NAME)
	@docker volume rm $(CONTAINER_VOLUME_HOME)
