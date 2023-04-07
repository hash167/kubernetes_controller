# Kubernetes controller to run load tests written in Bash

This repo conists of of a CRD for load tests, a deployment for a bash controller which checks for loadtest objects in each namespace and runs a loadtest based on the parameters. The idea of this project is to use the k8s API server(backed by etcd data store) as the API for our loadtest service

## Bash Controller

__controller.sh__ script that loops over all loadtests in all namespaces in a Kubernetes cluster, reconciles and runs them. 


The main function reconcile takes in two arguments, a namespace and a name, and reconciles and runs the corresponding loadtest. It first checks if the loadtest exists, and exits if it doesn't. Then it checks if the loadtest has already been run, and exits if it has. If the loadtest exists and has not been run, it extracts the method, address and duration from the loadtest definition, runs the loadtest using vegeta library, extracts the necessary metrics, and updates the status of the loadtest using kubectl patch.


The last few lines export the reconcile function, starts the loop over all loadtests in all namespaces, calling the reconcile function for each loadtest in a separate bash process.

## CRD

__controller_deploy.yaml__ defines a Kubernetes custom resource definition (CRD) for a load test. A CRD is an extension of the Kubernetes API and allows users to define their own custom resources alongside the built-in resources. 


The first part of the code sets the Kubernetes API version and specifies that a custom resource definition is being created. The metadata section defines the name of the CRD. The name must match the naming format <plural>.<group>.


The spec section defines the structure and schema of the custom resource. It specifies the API group name, version, and the structure of the custom resource using an openAPIV3Schema. Additionally, there are two printer columns defined to print the status of the resource.


Lastly, the names section defines the plural, singular, kind, and short names for the resource. The scope of the resource is specified as Namespaced, meaning it can only exist within a namespace.


Overall, this code creates a custom resource definition for a load test with the specified structure and schema, along with a set of naming rules and printer columns.

## How to run

1. Install [kind](https://kind.sigs.k8s.io/)
1. Create the cluster: make start
1. Create the controller docker image: make build
1. Push the image to kind: make push
1. Deploy all the Kubernetes files to the kind cluster: make apply

