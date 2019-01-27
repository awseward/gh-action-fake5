FROM awseward/gh-action-fake5:latest

LABEL "com.github.actions.name"="FAKE"
LABEL "com.github.actions.description"="Invoke a FAKE target"
LABEL "repository"="https://github.com/awseward/gh-action-fake5"
LABEL "maintainer"="Andrew Seward <awswrd@gmail.com>"

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
