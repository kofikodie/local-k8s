# EKS Getting Started Guide Configuration

This is the full configuration from https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html

See that guide for additional information.

NOTE: This full configuration utilizes the [Terraform http provider](https://www.terraform.io/docs/providers/http/index.html) to call out to icanhazip.com to determine your local workstation external IP for easily configuring EC2 Security Group access to the Kubernetes servers. Feel free to replace this as necessary.

## Getting started

You need to install [Terraform](https://www.terraform.io/intro) and then run the following commands:

```bash
terraform init
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

## Terraform

Terraform is an open-source infrastructure as code software tool created by HashiCorp. Users define and provide data center infrastructure using a declarative configuration language known as HashiCorp Configuration Language, or optionally JSON.

## Terraform Cloud
Additionally this project is using Terraform Cloud to manage the state of the infrastructure. To access the Terraform Cloud, you need to create an account on [Terraform Cloud](https://app.terraform.io/signup/account) and then join the PlanNgo workspace.

Terraform Cloud is a SaaS product that provides a web UI and API for managing Terraform runs. It is a commercial product, but it is free for open source projects.

## ARGOCD

Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes. It provides a declarative way to define application delivery: Continuous Deployment, Progressive Delivery, Blue Green Deployments, Automated Rollbacks, etc.

## ArgoCD Installation

### Prerequisites

Download the ArgoCD CLI from the [ArgoCD Releases](https://argo-cd.readthedocs.io/en/stable/cli_installation/) page.

### Install ArgoCD on Kubernetes

```bash
make argocd-install
```

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
