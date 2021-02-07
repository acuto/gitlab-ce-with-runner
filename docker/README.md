# GitLab CE with Runners

## Part One: The Docker stack

### Used Docker images:

```
- gitlab/gitlab-ce:13.8.0-ce.0
- gitlab/gitlab-runner:alpine-v13.8.0
- gitlab/gitlab-runner-helper:x86_64-775dd39d
- docker:latest
- docker:dind
- registry:2
- gcr.io/distroless/java:8
- mgmuhilan/dind-maven3-jdk8:latest
```

The Docker Compose script builds the following stack:

* `gitlab-ce-network`: the stack network
* `gitlab-ce`: the GitLab application node
* `gitlab-ce-runner`: the GitLab runner node

## Setup:

**Step 1.** Start the docker stack:

```sh
$ cd docker
$ docker-compose up -d

Building with native build. Learn about native build in Compose here: https://docs.docker.com/go/compose-native-build/
Creating gitlab-ce-runner ... done
Creating gitlab-ce        ... done
```

**Step 2.** Wait for the stack to be provisioned. You may follow the GitLab CE container log to inspect its readiness:

```sh
$ docker logs -f gitlab-ce
```

**Step 3.** Open the GitLab site in a browser, at the URL `http://localhost:40080`.

**Step 4.** Log in using the `root` user, and `DOAcademy` password (as set in `docker-compose.yml`).

**Step 5.** Register the runner. First, you need to get a registration token from GitLab. Open URL `http://localhost:40080/admin/runners` and, in the *"Set up a shared runner manually"* section, copy the token. Then edit the `gitlab-runner-register-linux.sh` or `gitlab-runner-register-windows.bat` file and paste the `registration_token` value as follows:

```sh
#!/bin/sh
# Get the registration token from:
# http://localhost:40080/admin/runners

registration_token=Tk61hMzULK8Ajr4JyCmG

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
```

Now you can execute the registration script:

```
$ ./gitlab-runner-register-linux.sh

Runtime platform                                    arch=amd64 os=linux pid=38 revision=264446b2 version=13.2.4
Running in system-mode.

Registering runner... succeeded                     runner=hY1VkGxi
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
```

**Step 6.** Finally, deploy the local Docker Registry onto which the artifact produced by the CI/CD pipeline will be pushed:

```
$ docker run -d --name registry -p 5000:5000 --restart always registry:2
```