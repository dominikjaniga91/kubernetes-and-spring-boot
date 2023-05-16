# kubernetes and spring boot

This repository contains of kubernetes yaml files. 

This is a continuation of previous task, the applcation images used in yaml files are images of user and post app from this repo https://github.com/dominikjaniga91/spring-boot-docker.

## Table of content
* [What to do](#what-to-do)
* [Task 1: Enable k8s](#task-1-enable-k8s)
* [Task 2: Deploy containers in k8s](#task-2-deploy-containers-in-k8s)
* [Task 3: Persistent volumes](#task-3-persistent-volumes)
* [Task 4: Stateful Sets](#task-4-stateful-sets)
* [Usage](#usage)

## What to do
In this module you will create infrastructure for your k8s cluster and deploy your microservices applications there.

## Task 1: Enable k8s
To use Kubernetes go to Docker Desktop settings, choose Kubernetes and click checkbox 'Enable Kubernetes'. You will need to wait for the installation and restart docker.
To verify installation run the next command: kubectl version.
It is recommended to install Kubernetes Lens to relieve resources management.

## Task 2: Deploy containers in k8s
In this subtask you need to create manifest .yml files with configuration for deployment. These files should contain the next objects:

Namespace (f.e. k8s-program). All other objects will use this namespace;
2 Services (one for each service of your system). Use NodePort service type and configure nodePort field for testing.
2 Deployments (one for each service of your system). For apps deployments set replicas: 2. You should add environment variables for your applications here.

Note: don't forget to specify namespace all objects. 
Delete EXPOSE instruction from dockerfiles and upgrade images. 
To deploy, run kubectl apply ./ in folders where yml files are stored.
To view all objects run kubectl get all -n=<your_namespace>. 
Along with services and deployments, this command outputs pods and replica-sets. Find out why.

## Task 3: Persistent volumes
In this subtask you will make your app pods use local storage. This will ensure that no data is lost during pod deploy/redeploy.

Add PersistentVolume object with "manual" storage class for the User service (create separate manifest file). Configure hostPath field so PersistentVolume create directory on the node.
Add PersistenceVolumeClaim objects to your manifest and reference them from User deployment object.
Test PersistentVolume: create any file inside the container in the volume directory, scale down deployment or delete pod, let replicaset automatically create pod, ensure that file still exists.


## Task 4: Stateful Sets

Use StatefulSet object (not Deployment) to create databases.
Configure default storage class "hostpath" for volume claim templates, so allowing k8s to provision storage with default provisioner (PersistentVolume will be created automatically).
Create 2 Services (one for each StatefulSet of your system). Use ClusterIP service type to restrict external access.

Note: You can also use kubectl port-forward pod-name 5433:5432 (local machine port:container port) console command to temporarily open access to the database pod

## Usage
```
git clone https://github.com/dominikjaniga91/kubernetes-and-spring-boot.git
cd kubernetes-and-spring-boot
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

Create statefull sets:
```
cd statefullset
kubectl apply -f .
```

Delete all:
```
kubectl delete all --all -n=k8s-program
```
