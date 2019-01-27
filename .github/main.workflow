workflow "Push base image to Docker Hub" {
  on = "push"
  resolves = ["docker build"]
}

action "docker login" {
  uses = "actions/docker/login@c08a5fc9e0286844156fefff2c141072048141f6"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "docker build" {
  uses = "actions/docker/cli@c08a5fc9e0286844156fefff2c141072048141f6"
  needs = ["docker login"]
  args = "build -t awseward/gh-action-fake5 .base/"
}
