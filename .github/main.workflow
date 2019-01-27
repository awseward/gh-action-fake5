workflow "Push base image to Docker Hub" {
  on = "push"
  resolves = ["Docker Registry"]
}

action "Docker Registry" {
  uses = "actions/docker/login@c08a5fc9e0286844156fefff2c141072048141f6"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}
