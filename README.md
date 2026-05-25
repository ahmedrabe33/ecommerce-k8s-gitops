# Ecommerce Kubernetes GitOps Repo

This repository contains the Kubernetes GitOps configuration for deploying the Ecommerce Microservices Platform on AWS EKS.

## Tools

- AWS EKS
- Kubernetes
- Helm
- Kustomize
- Argo CD
- AWS Load Balancer Controller
- Amazon EBS CSI Driver

## Target Environment

overlays/eks-prod -> production-like EKS deployment

## Production Design

This deployment is designed for an EKS cluster running across 3 Availability Zones.

Key features:

- Helm chart for reusable Kubernetes templates
- Kustomize overlay for EKS production
- Argo CD Application for GitOps sync
- ALB Ingress exposing only the gateway
- HPA for stateless services
- Topology spread constraints across Availability Zones
- StatefulSets with EBS gp3 StorageClass
- WaitForFirstConsumer volume binding

## Services

- gateway
- frontend
- admin
- user-auth
- catalog
- shopping
- inventory
- order-payment
- fulfillment
- platform
- postgres
- redis
- rabbitmq

## Important Stateful Note

StatefulSet provides stable pod identity and persistent storage.

It does not automatically provide database or message replication.

For real production data replication, prefer:

- PostgreSQL: Amazon RDS Multi-AZ or a PostgreSQL Operator
- Redis: Amazon ElastiCache Multi-AZ or Redis Operator
- RabbitMQ: Amazon MQ or RabbitMQ Cluster Operator

## Render EKS Manifests

Run:

make render-eks

## Apply to EKS

Make sure your kubeconfig points to the EKS cluster.

Run:

make apply-eks

## Argo CD

Before applying Argo CD app, edit:

argocd/ecommerce-prod-app.yaml

Replace:

REPLACE_WITH_USERNAME

with your GitHub username.

## Required EKS Add-ons

Before deploying this app, the EKS cluster should have:

- EBS CSI Driver
- AWS Load Balancer Controller
- Metrics Server
- Argo CD
