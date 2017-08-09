### docker stuff
===========

This creates a docker container with the local user added and mounts the local user's home directory. The user will have passwordless sudo access inside the container.

The docker image used is the latest Ubuntu from Docker Hub:

https://hub.docker.com/_/ubuntu/

#### Requirements

https://docs.docker.com/docker-for-mac/

#### Building the docker container

```shell
make build
```

The container will be tagged like so:

```
ubuntu:<username>
```

#### Running the docker container

```shell
make run
```
