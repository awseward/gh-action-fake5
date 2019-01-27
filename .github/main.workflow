workflow "Push base image to Docker Hub" {
  on = "push"
  resolves = ["images"]
}

action "login" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "build" {
  uses = "actions/docker/cli@master"
  needs = ["login"]
  args = "build -t base .base/"
}

action "tag" {
  uses = "actions/docker/tag@master"
  needs = ["build"]
  args = "base awseward/gh-action-fake5 --env"
}

action "images" {
  uses = "actions/docker/cli@master"
  needs = ["tag"]
  args = "images"
}
