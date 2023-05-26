# kubernetes and spring boot

This repository contains of kubernetes yaml files. 

This is a continuation of previous task (branch kubernetes). 
The application images used in yaml files are images of user and post app from this repo https://github.com/dominikjaniga91/spring-boot-docker.

## Table of content
* [What to do](#what-to-do)
* [Task 1: Secrets and config maps](#task-1-Secrets-and-config-maps)
* [Task 2: Liveness and Readiness probes](#task-2-liveness-and-readiness-probes)
* [Task 3: Deployment strategies](#task-3-deployment-strategies)
* [Task 4: Deployment history](#task-4-deployment-history)
* [Usage](#usage)
* [Solution for task 3 and 4](#solution-for-task-3-and-4)

## What to do

In this module you will manage secrets and properties for your k8s objects and study deployment strategies.

## Task 1: Secrets and config maps

1. Add Secrets object to your k8s manifest to store database username and password.
2. Add config maps to store environment variables for application deployments.
3. Add sql scripts to init databases (create tables) to config maps.
4. Change k8s Deployment and StatefulSet objects to load these secrets and config-maps.

## Task 2:Liveness and Readiness probes

1. Add endpoints for health checks at your applications.
2. Add startup, liveness and readiness probes for your Deployment objects at k8s manifest.
3. Add startup, liveness and readiness probes for your StatefulSet objects at k8s manifest

## Task 3: Deployment strategies

In this module you will add a field to one of your services, and perform Rolling-update deployment.

1. To Post service add a new field topic (:String). This is the topic for the post. You can specify it when creating a new post and when updating existing post. This field also should be returned at the responses for POST, PUT and GET operations.
2. Build a new docker image of application with changes and push it to the Docker Hub (specify another version of container).
3. Add Rolling-update deployment strategy to your deployments at manifest files and apply the  manifest, so the old versions of microservices are deployed and running.
4. Set app version of app containers to the new one and apply manifest one more time. Make sure that new changes are deployed.

## Task 4: Deployment history

As you deployed a new version of your application, you can see the history of your deployments. Your task is to roll back to previous version of your deployment without changing your manifest files.
Put in comments the solution of this task.

## Usage
```
git clone https://github.com/dominikjaniga91/kubernetes-and-spring-boot.git
cd kubernetes-and-spring-boot
git switch module-3
```

Create namespace:
```
kubectl apply -f namespace.yaml
```

Create user app, service, volumes and database:
```
cd user
kubectl apply -f .
```

Create post app, service, volumes and database:
```
cd post
kubectl apply -f .
```

Delete all:
```
kubectl delete all --all -n=k8s-program
```

## Solution for task 3 and 4

1. Change the version of image in post-deployment.yaml to 2.1
2. Recreate the deployment
```
kubectl apply -f post-deployment.yaml
```
3. Alternatively you can use the following command
```
kubectl set image deployments/post-app post-app=djanigaepam/post-service:2.1 -n=k8s-program
```
4. Validate deployment images
``` 
kubectl get deployments -o wide -n=k8s-program
```
5. Check deployment history
```
kubectl rollout history deploy post-app -n=k8s-program
```
6. Rollback to specific version
```
kubectl rollout undo deployment/post-app -n=k8s-program --to-revision=1
```
7. Validate images again
```
kubectl get deployments -o wide -n=k8s-program
```