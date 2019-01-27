workflow "Push base image to Docker Hub" {
  on = "push"
  resolves = ["push sha", "push latest"]
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

  args = "base $GITHUB_REPOSITORY --env"
}

action "push sha" {
  uses = "actions/docker/cli@master"
  needs = ["tag"]

  args = "push $GITHUB_REPOSITORY:$IMAGE_SHA"
}

action "master only" {
  uses = "actions/bin/filter@master"
  needs = ["tag"]

  args = "branch master"
}

action "push latest" {
  uses = "actions/docker/cli@master"
  needs = ["master only"]

  args = "push $GITHUB_REPOSITORY:latest"
}
