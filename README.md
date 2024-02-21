# Shahars Project

## Overview
This repository contains configurations and scripts for managing a MiniKube cluster environment on a Windows PC. The environment consists of a Kubernetes deployment and service running a containerized application. Images for the application are automatically built and pushed to a container registry in Dockerhub using GitHub Actions.

## Components
1. **MiniKube Cluster**: A local Kubernetes cluster running on Windows PC using MiniKube.
2. **Deployment**: Kubernetes deployment object specifying the desired state for the application.
3. **Service**: Kubernetes service object providing network access to the deployed application.
4. **GitHub Workflow**: Workflow for building and pushing Docker images to the container registry on each push to the main branch.
5. **Puppet Configuration**: Puppet scripts for managing Kubernetes resources and ensuring the environment's consistency.

## Prerequisites
- MiniKube installed and running on the local Windows PC.
    link to minikube documantation - https://minikube.sigs.k8s.io/docs/start/
- `kubectl` configured to communicate with the MiniKube cluster.
- Docker installed if you want to build container images locally.
- GitHub repository secrets configured for accessing the container registry. (this repository has already configured secrets to the shahar-project dockerhub registry)
- puppet installed 
    link to instructions on how to install puppet on windows

## Setup Instructions
1. Clone this repository to your local machine.
2. Install MiniKube and start the Kubernetes cluster.
3. Configure `kubectl` to communicate with the MiniKube cluster.
4. Set up Docker for building container images.
5. Configure GitHub repository secrets for Docker registry access.
6. Apply the Kubernetes manifests (`deployment.yaml` and `service.yaml`) to the MiniKube cluster.
    ```
    kubectl apply -f my-project-deployment.yaml
    kubectl apply -f my-project-service.yaml
    ```
7. Run Puppet scripts to manage the Kubernetes resources:
    ```
    puppet apply puppet-manifest.pp
    ```
8. Monitor the deployment and service to ensure the application is running correctly.


