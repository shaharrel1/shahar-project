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
    link to instructions on how to install puppet on windows - https://www.puppet.com/docs/puppet/5.5/install_windows.html

## Setup Instructions
1. Clone this repository to your local machine.
2. Install MiniKube and start the Kubernetes cluster.
3. Configure `kubectl` to communicate with the MiniKube cluster.
4. Configure GitHub repository secrets for Docker registry access.
5. Apply the Kubernetes manifests (`deployment.yaml` and `service.yaml`) to the MiniKube cluster.
    ```
    kubectl apply -f my-project-deployment.yaml
    kubectl apply -f my-project-service.yaml
    ```
6. Install puppet and run Puppet script to manage the Kubernetes resources:
    ```
    puppet apply puppet-manifest.pp
    ```
7. Once everything is set up you can access your app in the url you get when running the command - 
    ```
     minikube service shahar-project --url
    ```

## Monitoring
To monitor the deployment and service to ensure the application is running correctly i installed prometheus using helm - 
in the repository there is a prometheus.yml configuration file, I defined the targets that Prometheus should scrape for metrics. 
To use prometheus you need to run `path/to/prometheus.exe --config.file=path/to/prometheus.yml`
and then open your browser on - http://localhost:9090/
for the prometheus to work you need to:
-Adjust the IP address and port in the prometheus.yml file to the ip and port you get when running the command `minikube service shahar-project --url`
- Expose the metrics throuh /metrics in your repository. 
