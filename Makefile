default: build

build: build-latest build-alpine
.PHONY: build

build-latest:
	docker build -t jakzal/phpqa:latest .
.PHONY: build-latest

build-alpine:
	docker build -f Dockerfile-alpine -t jakzal/phpqa:alpine .
.PHONY: build-alpine


NIGHTLY_TAG := jakzal/phpqa-nightly:$(shell date +%y%m%d)
build-nightly:
	docker build -t $(NIGHTLY_TAG) .
	@docker login -u jakzal -p ${DOCKER_HUB_PASSWORD}
	docker push $(NIGHTLY_TAG)
.PHONY: build-nightly

NIGHTLY_ALPINE_TAG := jakzal/phpqa-nightly:$(shell date +%y%m%d)-alpine
build-nightly-alpine:
	docker build -f Dockerfile-alpine -t $(NIGHTLY_ALPINE_TAG) .
	@docker login -u jakzal -p ${DOCKER_HUB_PASSWORD}
	docker push $(NIGHTLY_ALPINE_TAG)
.PHONY: build-nightly-alpine
