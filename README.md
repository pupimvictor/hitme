# Hey Benchmark Docker and Kubernetes Example

This repository provides an example of running the [Hey](https://github.com/rakyll/hey) benchmark tool inside a Docker container and deploying it as a Kubernetes Job. This allows you to easily conduct load testing against a target endpoint using a containerized Hey benchmark.

## Prerequisites

Before using this repository, ensure you have the following prerequisites installed:

1. Docker: [Install Docker](https://docs.docker.com/get-docker/)
2. Kubernetes: [Install Kubernetes](https://kubernetes.io/docs/setup/)
3. kubectl: [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

## Usage

### Build the Docker image for Hey:

```bash
make build
```
This will create a Docker image named hey-container:latest based on the provided Dockerfile.
(Optional) If you need to push the Docker image to a container registry, update the push target in the Makefile with your registry details and run:

```bash
make push
```

Customize the Hey benchmark parameters in the overlays/production/kustomization.yaml file. Adjust the values in the configMapGenerator section to set the desired benchmark parameters.
Deploy the Hey benchmark as a Kubernetes Job using Kustomize. Replace production with the desired environment if needed:
```bash
make deploy KUBE_ENV=production
```

This will create a Kubernetes Job that runs the Hey benchmark with the specified parameters.
Monitor the progress of the Hey benchmark and check the logs:

```bash
make logs
```

After the Job completes, you can review the benchmark results in the logs.
Clean up and delete the Kubernetes Job when done:
```bash
make clean
```


### Customizing Parameters

You can customize the Hey benchmark parameters by editing the overlays/production/kustomization.yaml file and adjusting the values in the configMapGenerator section. This allows you to easily conduct different load tests with varying parameters.

### Contributing

If you'd like to contribute to this repository or report issues, please create an issue or submit a pull request.

### License

This project is licensed under the MIT License. See the LICENSE file for details.

