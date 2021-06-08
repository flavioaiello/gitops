# GitOps
AllSpark is inspired by the hyperscalers and its purpose is to automatically configure multiple Kubernetes clusters.

## Architecture

## AllSpark
The inception is done by means of a local workstation or via a management cluster. Depending on this, temporary or long lived cluster services such as Kubernetes can be deployed. With Crossplane, services can request more advanced resources such as Databases. AllSpark starts automatically the required services below. The inception is done deploying `make minikube` on a local minikube. Once Minikube is operational, clusters can be provisioned on GCP or AWS.

* Argo CD
* Crossplane

## Services
Services are defined depending on the cloud. The base configuration is environment agnostic and the overlays include specifics such as storage, load balancers, etc.

* Argo Events
* Argo Workflow
* Argo Rollouts
* Artifacthub
* Jira
* etc.