IMAGE_REPO = docker.io/bollohz
IMAGE_NAME = react-image-compressor
IMAGE_TAG  = 1.0.0

.PHONY: build push image start
build-prod:
	@echo "Building docker image..."
	@docker build -t $(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG) -f Dockerfile_Production .

push-prod:
	@echo "Pushing the docker image for $(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG) and $(IMAGE_REPO)/$(IMAGE_NAME):latest..."
	@docker tag $(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG) $(IMAGE_REPO)/$(IMAGE_NAME):latest
	@docker push $(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG)
	@docker push $(IMAGE_REPO)/$(IMAGE_NAME):latest

image-prod:
	@echo "Baking the image...."
	$(MAKE) build-docker
	$(MAKE) push-docker

build:
	@echo "Building up the image....."
	@docker-compose -f docker-compose.yaml build

start:
	@echo "Starting the app locally...."
	@docker-compose up -d --remove-orphans



