# Define the directory path variable
$yaml_dir = "C:/Users/Tom/shahar-project/shahar-project"

# Define a custom resource type to manage Kubernetes resources
define kubernetes_resource($resource_type, $resource_name, $resource_content) {
  file { "${yaml_dir}/${resource_name}.yaml":
    ensure  => file,
    content => $resource_content,
    mode    => '0644',
  }
}

# Manage the deployment
kubernetes_resource { 'shahar-project-deployment':
  resource_type    => 'Deployment',
  resource_name    => 'my-project-deployment',
  resource_content => '
apiVersion: apps/v1
kind: Deployment
metadata:
  name: shahar-project
spec:
  replicas: 1
  selector:
    matchLabels:
      app: shahar-project
  template:
    metadata:
      labels:
        app: shahar-project
    spec:
      containers:
      - name: shahar-project
        image: docker.io/shaharrel/my-node-project:latest
        imagePullPolicy: Always
        ports:
        - containerPort: 3000
',
}

# Manage the service
kubernetes_resource { 'shahar-project-service':
  resource_type    => 'Service',
  resource_name    => 'my-project-service',
  resource_content => '
apiVersion: v1
kind: Service
metadata:
  name: shahar-project
spec:
  selector:
    app: shahar-project
  ports:
    - protocol: TCP
      port: 3000
      targetPort: 3000
  type: NodePort
',
}

# Execute the kubectl rollout restart command for deployment
exec { 'Rollout Restart Deployment':
  command   => "C:/minikube/minikube.exe kubectl rollout restart deployment shahar-project",
  subscribe => [
    Kubernetes_resource['shahar-project-deployment'],
    Kubernetes_resource['shahar-project-service'],
  ],
}

# Manage Prometheus configuration manually
file { 'prometheus.yml':
  path    => 'C:/prometheus-2.49.1.windows-amd64/prometheus.yml',
  content => "
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'kubernetes-service-endpoints'
    kubernetes_sd_configs:
    - role: service
    relabel_configs:
      - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_scrape]
        action: keep
        regex: true
      - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_path]
        action: replace
        target_label: __metrics_path__
        regex: (.+)
      - source_labels: [__meta_kubernetes_namespace]
        action: replace
        target_label: kubernetes_namespace
      - source_labels: [__meta_kubernetes_service_name]
        action: replace
        target_label: kubernetes_name

  # Add the scrape configuration for the 'shahar-project' service
  - job_name: 'shahar-project'
    static_configs:
      - targets:
        - '172.23.23.152:31684'  # Adjust the IP address and port as per your service
",
}
