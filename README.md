# kubernetes and spring boot

This repository contains of kubernetes yaml files. 

This is a continuation of previous task (branch _kubernetes_ and _module-3_). 
The application images used in yaml files are images of user and post app from this repo https://github.com/dominikjaniga91/spring-boot-docker.

## Table of content
* [What to do](#what-to-do)
* [Task 1: Helm charts](#task-1-helm-charts)
* [Task 2: Helm chart helpers](#task-2-helm-chart-helpers)
* [Task](#usage)

## What to do

In this module you will learn how to attach persistent storages to your applications. Also, you will understand how helm charts work.

## Task 1: Helm charts

1. Install helm Official download link.
2. Add helm chart to deploy your applications. Make replica-count and namespace a helm values.
3. Add helm values file to store default values for helm variables.
4. Run helm using helm install command to deploy applications with default helm variables. Make sure, your applications are up and running.
5. Run helm once again, but this time set namespace and replica-count for helm intall to non-default values.

## Task 2: Helm chart helpers

1. Create helm _helpers.tpl file and define next labels there:
   * current date : use helm generator for it's value
   * version
2. Make config-map use values as labels from helm _helpers.tpl file.

## Usage
```
git clone https://github.com/dominikjaniga91/kubernetes-and-spring-boot.git
cd kubernetes-and-spring-boot
git switch helm
```

Create namespace:
```
kubectl apply -f namespace.yaml
```

Create user app, service, volumes and database:
```
cd user
helm install user .
```

Create post app, service, volumes and database:
```
cd post
helm install post .
```

Delete all:
```
helm delete user
helm delete post
```
The above commands install resources in the default namespace, you can verify this by using:

```
helm list
```
However kubernetes reaource are still available in k8s-program namespace:
```
kubectl get all -n=k8s-program
```
Use the following commands to set specific values like namespace or replica count:
```
helm install user --namespace k8s-program --set replicas.app=3 --set replicas.database=1 .
helm install post --namespace k8s-program --set replicas.app=3 --set replicas.database=1 .
```

Verify the results:

```
helm list --namespace k8s-program
kubectl get all -n=k8s-program
```