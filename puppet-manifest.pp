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
