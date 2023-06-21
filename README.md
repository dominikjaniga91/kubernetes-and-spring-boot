# kubernetes and spring boot

This repository contains of kubernetes yaml files. 

This is a continuation of previous task (branch _kubernetes_ and _module-3_). 
The application images used in yaml files are images of user and post app from this repo https://github.com/dominikjaniga91/spring-boot-docker.

## Table of content
* [What to do](#what-to-do)
* [Task 1: Ingress](#task-1-ingress)
* [Task](#usage)

## What to do

In this module you will learn how to install ingress controller and route traffic to your applications. Also, you will practice helm.

## Task 1: Ingress

1. Install ingress controller using helm chart. (guide)
2. Change Services type to ClusterIP to restrict external access.
3. Create ingress resource and route your traffic using rules.
4. Configure rewrite-target of path using annotations. Example routing: from http://localhost/posts/api/v1/greeting to http://posts:8080/api/v1/greeting. (ref docs)

## Usage
```
git clone https://github.com/dominikjaniga91/kubernetes-and-spring-boot.git
cd kubernetes-and-spring-boot
git switch networking
```

Create namespace:
```
kubectl apply -f namespace.yaml
```

Create ngnix ingress controller
```
helm repo add nginx-stable https://helm.nginx.com/stable
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install my-ingress ingress-nginx/ingress-nginx
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

Check ingress:
```
 kubectl get ingress -n=k8s-program
 kubectl get all | grep my-ingress
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