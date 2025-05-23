# Configuring Self-Hosted GitLab Project Runners

1. Get a runner token from GitLab:
- GitLab Repo Settings > CI/CD > Runners:
    - Turn off `Enable instance runners for this project`
    - Create project runner:
        - Tags: `dockerExecutor`
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
    ```
- GitLab instance URL: `https://gitlab.com`
- Registration Token: `glr...`
- Runner Name: `fawry-internship-docker-runner`
- Executor: `docker`
- Default Docker Image (the default image used when a job in `.gitlab-ci.yml` does not explicitly specify one): `alpine:latest`

4. Start a Bitnami GitLab Runner container with the Docker executor:
    ```bash
    docker run -d --name gitlab-runner-docker \
      -u root \
      -v /var/gitlab_runner_config:/etc/gitlab-runner \
      -v /var/run/docker.sock:/var/run/docker.sock \
      bitnami/gitlab-runner:latest
    ```

5. Add the runner tag to your `.gitlab-ci.yml` to use the runner, for example:
    ```yaml
    default:
      tags:
        - local-runner

    job1:
      tags: [special-runner]
      script:
        - echo "Custom tag for job 1"

    job2:
      script:
        - echo "Uses default tag from `default:`"
    ```
