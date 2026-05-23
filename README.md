## Overview

This project demonstrates how to deploy a Node.js-based Threat Modelling Tool on AWS using Docker, ECS Fargate, and Terraform. The app is served securely over HTTPS with a custom domain and load-balanced for high availability.

## Tech Stack & Architecture Design

- Node.js Application - Core threat modelling tool
- Docker - Containerised application
- CI/CD - GitHub Actions pipeline for automated builds & destroys
- Amazon ECS Fargate - Serverless container orchestration
- Terraform - Infrastructure provisioning
- Application Load Balancer (ALB) - Traffic routing and availability
- AWS Certificate Manager (ACM) - TLS/SSL certificate management
- Cloudflare DNS - Public DNS and domain management
- Docker Hub - Container image registry
- VPC + Security Groups - Network isolation and security

![Architecture Diagram](Architecture_Design.png)

# Browser Demo (Domain & Redirect Working)

![Browser Demo](browser-demo.gif)

# Terminal Demo (Status Check)

![Terminal Demo](terminal-demo.gif)

## Design Choices

- I chose Fargate over EC2 because I wanted a more managed offering that's hands-off
- I chose Docker Hub over ECR because it's cloud agnostic which gives more flexibility
- I chose Terraform over CloudFormation as it's the most used IAC tool for infrastructure provisioning
- I chose Cloudwatch over Prometheus & Grafana because it's native to AWS so it was easier to implement
- I chose an ALB over NLB as I needed routing for HTTP/HTTPS

## Instructions on Deployment

-git clone git@github.com:amuwonge99/Threat_Modelling_Tool.git
-cd ECS_Project
-Make a small change on a file (e.g. add a # on a blank line)
-git add <file_name>
-git commit -m "<message>"
-git push

## Prerequisites
- AWS account with CLI configured
- Cloudflare account & registered domain  
- Docker & Node.js installed  
- Terraform installed 

#mention of IAM roles, secrets management, or scaling considerations.

