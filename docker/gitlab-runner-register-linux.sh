#!/bin/sh
# Get the registration token from:
# http://localhost:40080/admin/runners

registration_token=XXXXXXXXXXXXXXXXXXXX

docker exec -it gitlab-ce-runner \
  gitlab-runner register \
    --non-interactive \
    --registration-token ${registration_token} \
    --locked=false \
    --description docker-stable \
    --url http://host.docker.internal:40080 \
    --executor docker \
    --docker-image docker:stable \
    --docker-volumes "/var/run/docker.sock:/var/run/docker.sock" \
    --docker-network-mode gitlab-ce-network