Overview

The goal of this project was to deploy a node.js-based Threat Modelling Tool using Infrastructure as Code. The application is containerised using Docker and deployed on AWS using Amazon ECS with Fargate. Infrastructure provisioning is automated with Terraform, while secure HTTPS access is enabled using AWS Certificate Manager (ACM). The application is exposed through a custom domain managed by Amazon Route 53 and is behind an Application Load Balancer (ALB).

# Domain & Redirect Working

[![Threat Modelling Tool Browser View](demo.gif)](./threat-modelling-tool-web-browser.mp4)

# Status Check

[![Threat Modelling Tool Terminal View](demo2.gif)](./threat-modelling-tool-terminal.mp4)



Design Choices

I chose Fargate over EC2 because I wanted a more managed offering that's hands-off
I chose Docker Hub over ECR because it's cloud agnostic which gives more flexibility
I chose Terraform over CloudFormation as it's the most used IAC tool for infrastructure provisioning.
I chose Cloudwatch over Prometheus & Grafana because it's native to AWS so it was easier to implement
I chose ALB over NLB as I wanted routing for HTTP/HTTPS

#Include instructions on deployment, prerequisites, or running the project. A production-grade README should allow someone else to understand and replicate your setup.
#include architecture design
#mention of IAM roles, secrets management, or scaling considerations.

