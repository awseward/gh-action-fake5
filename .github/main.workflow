workflow "Push base image to Docker Hub" {
  on = "push"
  resolves = ["push sha", "push latest"]
}

action "login" {
  uses = "actions/docker/login@c08a5fc9e0286"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "build" {
  uses = "actions/docker/cli@c08a5fc9e0286"
  needs = ["login"]

  args = "build -t base .base/"
}

action "tag" {
  uses = "actions/docker/tag@c08a5fc9e0286"
  needs = ["build"]

  args = "base $GITHUB_REPOSITORY --env"
}

action "push sha" {
  uses = "actions/docker/cli@c08a5fc9e0286"
  needs = ["tag"]

  args = "push $GITHUB_REPOSITORY:$IMAGE_SHA"
}

action "master only" {
  uses = "actions/bin/filter@db72a46c8ce29"
  needs = ["tag"]

  args = "branch master"
}

action "push latest" {
  uses = "actions/docker/cli@c08a5fc9e0286"
  needs = ["master only"]

  args = "push $GITHUB_REPOSITORY:latest"
}
