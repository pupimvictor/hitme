IMAGE_NAME = hitme
IMAGE_TAG = latest
REGISTRY = pupimvictor

KUBE_ENV = production
KUBE_JOB_NAME = hey-job

# args = $(foreach a,$($(subst -,_,$1)_args),$(if $(value $a),$a="$($a)"))
# args=`"$(filter-out $1,$(MAKECMDGOALS))" && echo $${arg:-${2}}`
args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`

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
	@kubectl exec -n hitter -it deployment/hitme-$(call args,defaultstring) -- sh

redeploy: clean deploy
	
all: build push clean deploy 
	sleep 5
	kubectl logs -f job/$(KUBE_JOB_NAME)

.PHONY: build push deploy logs clean all
