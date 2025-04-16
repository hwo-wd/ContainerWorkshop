# Container Workshop, 16.04.25

* [Container Workshop, 16.04.25](#container-workshop-160425)
  * [Non-goals](#non-goals)
  * [Introduction](#introduction)
    * [History](#history)
    * [DOs and DON'Ts](#dos-and-donts)
  * [Hands-On](#hands-on)
  * [Container Hardening](#container-hardening)

## Non-goals

* K8s
* "cloud-native"

## Introduction

### History

* Linux: chroot; cgroups + namespaces
* history
  * 2013: Docker CLI <-> Docker Daemon (monolith, runs as **root**) <-> LXC
  * Open Container Initiative (`OCI`) and Container Runtime Interface (`CRI`)
    * [containerd](https://github.com/containerd/containerd) und containerd-shim (docker)
      * CLI: `nerdctl` (contaiNERD CTL)
    * [CRI-O](https://github.com/cri-o/cri-o) (Red Hat)
  * [runc](https://github.com/opencontainers/runc)
  * [Podman](https://github.com/containers/podman)
* Status Quo:
  * K8s
  * ~~docker swarm~~
  * Container Runtimes: runc, containerd, cri-o
  * rootless containers
  * "distroless" images
    > "Distroless" images contain only your application and its runtime dependencies. They do not contain package managers, shells or any other programs you would expect to find in a standard Linux distribution.
  * Podman: [Quadlets](https://news.ycombinator.com/item?id=43683641)
  * O11y (grafana, prom etc.)
  * SBOM, attestation etc.
* Future
  * bootable containers ([`bootc`](https://github.com/bootc-dev/bootc))

### DOs and DON'Ts

* DOs
  * use docker compose v2:
    * for *single-node* environments
    * for developer environment setups; depending on your use case, you might also want to consider [Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
  * if on Windows or MacOS:
    use [podman desktop](https://podman-desktop.io/) or Docker Desktop; beware about the licensing of the latter!
  * if on Linux: there's no need for a VM
    use [podman](https://podman.io/docs/installation#installing-on-linux) and get used to the CLI
  * try to go rootless, whenever possible
  * keep images up-to-date
  * be explicit about images, don't assume that docker hub is the standard, i.e. ~~`alpine:3.14`~~ -> `docker.io/library/alpine:3.14`
* DON'Ts
  * do NOT use docker swarm, use K8s instead
  * do NOT use `latest` tag, unless you know what you are doing
  * do NOT use `docker-compose` (v1), but use `docker compose` (v2, note the missing hyphen)

## Hands-On

* ~~Docker~~ Podman Installation, hello-world OCI Image

```bash
podman machine start
# podman container run hello-world # -> or better:
podman container run quay.io/podman/hello:latest
```

* CLI

```bash
podman --help
```

```bash
podman container --help
podman image --help
podman volume --help
podman network --help
```

* Containerfiles and Image Layers
  * [Reference](https://docs.docker.com/reference/dockerfile/)

```bash
cd Containerfiles
podman image build -f alpine-mysql-client.containerfile -t localhost/my-alpine:v0.1-alpha1
```

```bash
podman container run -it localhost/my-alpine:v0.1-alpha1
```

```bash
podman container run -it --entrypoint sh localhost/my-alpine:v0.1-alpha1
```

```bash
dive localhost/my-alpine:v0.1-alpha1
```

* Images
  * Image Tags on an example: <https://hub.docker.com/_/alpine>

* OCI Registries
  * [Docker Hub](https://hub.docker.com/)
  * [Quay.io](https://quay.io/)
  * [Microsoft Container Registry](https://mcr.microsoft.com)
  * [Github Container Registry](https://ghcr.io)
* docker compose
  * Simple: <https://github.com/world-direct/keycloak-theme-world-direct/blob/main/compose.yaml>

```bash
pushd ~/dev/work/keycloak-theme-world-direct
podman compose up
popd
```

* walk through `./compose` and give it a shot

## Container Hardening

* uid/gid within the container
