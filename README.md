# EKS Getting Started Guide Configuration

This is the full configuration from https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html

See that guide for additional information.

NOTE: This full configuration utilizes the [Terraform http provider](https://www.terraform.io/docs/providers/http/index.html) to call out to icanhazip.com to determine your local workstation external IP for easily configuring EC2 Security Group access to the Kubernetes servers. Feel free to replace this as necessary.

This configuration also includes an addons resource for creating an [AWS elastic block store](https://aws.amazon.com/ebs/) (EBS) volume and mounting it to the Kubernetes worker nodes. This is useful for storing persistent data on the worker nodes. This is not required for the EKS cluster to function.
## Terraform

Terraform is an open-source infrastructure as code software tool created by HashiCorp. Users define and provide data center infrastructure using a declarative configuration language known as HashiCorp Configuration Language, or optionally JSON.

To install Terraform, follow the instructions at https://www.terraform.io/intro/getting-started/install.html

Additionally this project is using Terraform Cloud to manage the state of the infrastructure. To access the Terraform Cloud, you need to create an account on [Terraform Cloud](https://app.terraform.io/signup/account) and create an workspace for this project.

Terraform Cloud is a SaaS product that provides a web UI and API for managing Terraform runs. It is a commercial product, but it is free for open source projects. Once you have created an account, you can create a workspace for this project. You can also use the [Terraform Cloud CLI](https://www.terraform.io/docs/cloud/run/cli.html) to manage the state of the infrastructure.

## Getting started

To initialize the project, run the following commands:

```bash
terraform init
```

To format the hcl files, you can run the following command:

```bash
terraform fmt
```

To add new resources to the project, open a pr. Once the pr is merged, the changes be will automatically be apply.

This project is using [Infracost](https://www.infracost.io/) to estimate the cost of the infrastructure. Once a pr is opened, Infracost will automatically add a comment with the estimated cost of the infrastructure.

## Connecting to the cluster

```bash
aws eks update-kubeconfig --name <cluster_name>
```

## ARGOCD

Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes. It provides a declarative way to define application delivery: Continuous Deployment, Progressive Delivery, Blue Green Deployments, Automated Rollbacks, etc.

## ArgoCD Installation

### Prerequisites

Download the ArgoCD CLI from the [ArgoCD Releases](https://argo-cd.readthedocs.io/en/stable/cli_installation/) page.

### Install ArgoCD on Kubernetes

```bash
make argocd-install
```

### Access ArgoCD-UI

To access the ArgoCD-UI, you need to run the following command:

```bash
make argocd-ui
```

Now you can access the ArgoCD-UI on http://localhost:8080

Alternatively, you can create a load balancer service for the argocd-server service to access the ArgoCD-UI from outside the cluster.

```bash
make argocd-ui-lb
```

Now you can access the ArgoCD-UI on http://<load_balancer_dns_name>

## ArgoCD Login

To login to ArgoCD, you need to run the following command:

First you need to get the password for the admin user:

```bash
make argocd-get-password
```

Then you need to login to ArgoCD:

```bash
argocd login localhost:8080 --username admin --password <password>
```

In case you have created a load balancer service for the argocd-server service, you need to run the following command:

```bash
argocd login <load_balancer_dns_name> --username admin --password <password>
```

## ArgoCD Deployments

### Deploying the application from git repository

To deploy the application from git repository, you need to first:

set the current namespace to argocd running the following command: 
```bash
kubectl config set-context --current --namespace=argocd
```

Then you need to run the following command:

```bash
argocd app create <application_name> --repo <url_git_repo> --path <path> --dest-server https://kubernetes.default.svc --dest-namespace default --sync-policy automated
```

## OPA Gatekeeper

OPA Gatekeeper is a policy engine for Kubernetes. It allows you to define custom policies that are enforced when resources are created or updated.

## OPA Gatekeeper Installation

To deploy OPA Gatekeeper, you need to run the following command:

```bash
make opa
```

To verify that the OPA Gatekeeper is running, you need to run the following command:

```bash
kubectl get pods -n gatekeeper-system
```

For more information about OPA Gatekeeper, you can visit the [Using Open Policy Agent (OPA) for policy-based control in EKS](https://www.eksworkshop.com/intermediate/310_opa_gatekeeper) page.

## KEDA

KEDA is a Kubernetes-based event-driven autoscaling component. It allows you to define custom policies that are enforced when resources are created or updated.

## KEDA Installation

### Prerequisites
To configure KEDA, you need to install the metrics server. To install the metrics server, you need to run the following command:

```bash
make metrics-server
```

To deploy KEDA, you need to run the following command:

```bash
make keda
```