# Main components
https://www.youtube.com/watch?v=Krpb44XR0bk&list=PLy7NrYWoggjziYQIDorlXjTvvwweTYoNC&index=2

# Architecture

* Cluster has one master node, and multiple worker nodes
* Master node runs (only has to be small instance):
  - The K8s API server - it's the cluster entry point, hosts/interfaces UI, API, CLI
  - Controller manager - manages processes, restarting them if the die, etc.
  - Scheduler - decides which nodes processes should run on based on load
  - etcd - key/value store DB for the k8s cluster
  - If the master goes down, the whole cluster becomes unavailable. Need to be backed up, or have a second "backup" instance running
* Worker nodes (tend to be big instances): run one or more Docker containers for the application(s)
* Master communicates with workers through a "virtual network"

Pod (container) [runs on]> Node <-> Service > Cluster

Pod
* Pods each have their own IP address, new IP address given when a pod is restarted.
* Because the pod IP address can change, there's another layer in between called "service" that has as static IP and acts as a load balancer
* you'd mainly work with deployments and not pods
* database can't be replicated for deployment (bottleneck), but k8s StatefulSet is designed for replicating databases and syncing r/w ops (deployment vs statefulset) 
* 

Service
* permanent IP address
* extenal service - accessible from the web. Address is IP address of node + port. 
* internal service - accessible within, like DB
* Has volumes attached
* Replicas of the same service run on multiple nodes (the redundancy)

Ingress
* proxy that forwards web domain address to external service address on node

ConfigMap
* mapping/routing table of service names and the endpoints (i.e. DATABASE_URL)


Other useful tools:
* [external-dns](https://github.com/kubernetes-sigs/external-dns) - configure external DNS servers


# Other tools used locally (Winston)
`k9s`

```
gregwoods@HQMAC-MOS00364 ~ % kubectl config get-contexts 
CURRENT   NAME                                                     CLUSTER                                                  AUTHINFO                                                 NAMESPACE
          arn:aws:eks:us-east-1:377522303979:cluster/moser-eks-1   arn:aws:eks:us-east-1:377522303979:cluster/moser-eks-1   arn:aws:eks:us-east-1:377522303979:cluster/moser-eks-1   
*         do-nyc1-moser-spenio                                     do-nyc1-moser-spenio                                     do-nyc1-moser-spenio-admin                               default
          do-nyc3-moser-spenio-production                          do-nyc3-moser-spenio-production                          do-nyc3-moser-spenio-production-admin                    
```

`kubectx` allow quick context switching


# Node setup  
https://www.youtube.com/watch?v=umXEmn3cMWY&list=PLy7NrYWoggjziYQIDorlXjTvvwweTYoNC&index=3

Node Components:
* Container runtime - installed on every node
* Kubelet - interacts with container (starts container in pod) and node
* Kube proxy - installed on every node. forwards requests efficiently (routes traffic intranode)

Master Node components:
* API Server (gateway to the cluster of nodes) - forwards requests to nodes/pods/processes, authentication
* Scheduler
* Controller manager - knows status of cluster and nodes
* etcd - k8s database

# Minikube
kind - alternative to minikube?

minikube - local setup for testing running on virtual machine
* single node running locally

kubectl - k8s cluster CLI

Commands:
```
# Will need to figure out correct vm-driver for WSL 
> minikube start --vm-driver=<hyperkit>

> kubectl get nodes

> minikube status
```

Instructions for setting up minikube on WSL: https://magda.io/docs/installing-minikube.html
* Added Windows minikube context from `%userprofile%\.kube\config` to `~/.kube/config` in WSL Debian
* Put this in /usr/local/bin/minikube
```
#!/bin/sh
/mnt/c/ProgramData/chocolatey/bin/minikube.exe $@
```

Other recommended settings:
```
minikube config set memory 6144
minikube config set cpus 2
minikube config set vm-driver virtualbox

```

# kubectl basic commands

* Deployment is an abstraction layer for working with pods
* Deployment has the blueprints for creating the pods
* 
```
$ kubectl get nodes
NAME                   STATUS   ROLES    AGE   VERSION
pool-43iad2dfb-ft681   Ready    <none>   49d   v1.24.13
pool-43iad2dfb-ft68q   Ready    <none>   49d   v1.24.13
```

Make a deployment
```
$ kubectl create deployment <name> --image=<docker image name>

$ kubectl get deployment
NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
ingress-nginx-controller   1/1     1            1           2y304d
```

Replicaset - auto created. Shows all the pods in service.
Deployment > Replicaset > Pods
```
$ kubectl get pod
NAME
nginx-depl-792834792

$ kubectl get replicaset
NAME
nginx-depl-792834792-sdfscd
```

* If you wanna make a change, like to the image, you have to do that in the deployment config.
```
$ kubectl edit deployment

#=> shows you auto generated deployment 
```

# Other Tools

kubectx - switch context
kubens - switch namespace