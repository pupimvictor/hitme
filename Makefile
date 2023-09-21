IMAGE_NAME = hitme
IMAGE_TAG = latest
REGISTRY = pupimvictor

KUBE_ENV = production
KUBE_JOB_NAME = hey-job

build:
	docker build -t $(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG) .

push:
	# Push the Docker image to your container registry if needed
	docker push $(REGISTRY)/$(IMAGE_NAME):$(IMAGE_TAG)

deploy:
	kubectl apply -k kustomize

logs:
	kubectl logs -f job/$(KUBE_JOB_NAME)

clean:
	kubectl delete job $(KUBE_JOB_NAME)

exec:
	kubectl exec -it jobs/hey-job -- bash

all: build push clean deploy 
	sleep 5
	kubectl logs -f job/$(KUBE_JOB_NAME)

.PHONY: build push deploy logs clean all
