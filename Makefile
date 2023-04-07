CLUSTER_NAME ?= bash-controller

start:
	kind create cluster --name $(CLUSTER_NAME)

build:
	docker build -t tbd.com/loadtest-controller:v1 .

push:
	kind load docker-image tbd.com/loadtest-controller:v1

apply:
	kubectl apply -f k8s

run:
	docker run -it --rm tbd.com/loadtest-controller:v1
