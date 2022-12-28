# EKS Getting Started Guide Configuration

This is the full configuration from https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html

See that guide for additional information.

NOTE: This full configuration utilizes the [Terraform http provider](https://www.terraform.io/docs/providers/http/index.html) to call out to icanhazip.com to determine your local workstation external IP for easily configuring EC2 Security Group access to the Kubernetes servers. Feel free to replace this as necessary.


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

Before you can check the changes that will be applied

```bash
terraform plan
```

Once the initialization is done, you can run the following command to apply any changes:

```bash
terraform apply -auto-approve
```

To destroy the infrastructure, you can run the following command:

```bash
terraform destroy -auto-approve
```

## Connecting to the cluster

```bash
terraform output kubeconfig > ~/.kube/config
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

## ArgoCD Deployments

### Deploying the application from git repository

To deploy the application from git repository, you need to first:

set the current namespace to argocd running the following command: 
```bash
kubectl config set-context --current --namespace=argocd
```

Then you need to run the following command:

```bash
argocd app create guestbook --repo <url_git_repo> --path <path> --dest-server https://kubernetes.default.svc --dest-namespace default --sync-policy automated
```
