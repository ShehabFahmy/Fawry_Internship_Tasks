# Configuring Self-Hosted GitLab Project Runners

1. Get a runner token from GitLab:
- GitLab Repo Settings > CI/CD > Runners:
    - Turn off `Enable instance runners for this project`
    - Create project runner:
        - Tags: `DockerExecutor, local-runner`
        - Check the `Run untagged jobs` box
        - Check the `Lock to current projects` box
        - Click on `Create runner`

2. Pull the GitLab runner image:
    ```bash
    docker pull bitnami/gitlab-runner:latest
    ```

3. Register the runner for the first time:
    ```bash
    docker run --rm -it \
      -u root \
      -v /var/gitlab_runner_config:/etc/gitlab-runner \
      bitnami/gitlab-runner:latest register
    sudo sed -i '/^\s*volumes = \[.*\]/ s/\(\[.*\)\]/\1, "\/var\/run\/docker.sock:\/var\/run\/docker.sock"]/g' /var/gitlab_runner_config/config.toml
    ```
- GitLab instance URL: `https://gitlab.com`
- Registration Token: `glr...`
- Runner Name: `fawry-internship-gitlab-docker-runner`
- Executor: `docker`
- Default Docker Image (the default image used when a job in `.gitlab-ci.yml` does not explicitly specify one): `alpine:latest`

4. Start a Bitnami GitLab Runner container with the Docker executor:
    ```bash
    docker run -d --name fawry-internship-gitlab-docker-runner \
      -u root \
      -v /var/gitlab_runner_config:/etc/gitlab-runner \
      -v /var/run/docker.sock:/var/run/docker.sock \
      bitnami/gitlab-runner:latest
    ```

5. Add the runner tag to your `.gitlab-ci.yml` to use a specific runner, or simply don't use any tags since we enabled `Run untagged jobs`.
