IMAGE_REPO = docker.io/bollohz  #Change with something related to ECR here in order to push it on AWS ECR
IMAGE_NAME = react-image-compressor
IMAGE_TAG  = 1.0.0
NAMESPACE  = default

.PHONY: build build-prod push-prod image-prod start buildnocache test
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

test:
	@echo "Write some test and run testing in CI for a better process..."


build:
	@echo "Building up the image....."
	@docker-compose -f docker-compose.yaml build

buildnocache:
	@echo "Building up the image....."
	@docker-compose -f docker-compose.yaml build --nocache

start:
	@echo "Starting the app locally...."
	@docker-compose -f docker-compose.yaml up -d --remove-orphans

.PHONY: chart-lint chart-template chart-install

chart-lint:
	@echo "Linting helm chart"
	@helm3 lint helm/react-image-compressor -f helm/react-image-compressor/values.yaml

chart-template:
	@echo "Chart template generation..."
	@helm3 template helm/react-image-compressor -f helm/react-image-compressor/values.yaml > helm/react-image-compressor/out.yaml --debug

chart-install:
	@echo "Release the chart...."
	$(MAKE) chart-test
	@helm3 upgrade --install react-image-compressor helm/react-image-compressor --namespace ${NAMESPACE} --version 1.0.0 --debug

chart-test:
	@echo "Testing the k8s manifest..."
	$(MAKE) chart-lint
	helm3 template helm/react-image-compressor -f helm/react-image-compressor/values.yaml | docker run --rm -i garethr/kubeval --strict --ignore-missing-schemas

test-codebuild:
	@echo "Testing codebuild buildspec!"
	./codebuild_build.sh -i aws/codebuild/standard:3.0 -a $(PWD)/aws/output


