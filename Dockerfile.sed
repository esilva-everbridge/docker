FROM ubuntu:latest

COPY scripts/adduser.sh /tmp/adduser.sh

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y apt-utils sudo bash tcsh zsh \
    openssh-client openssh-server \
    tmux git python3 && \
    DOCKER_USER=DOCKER_USER DOCKER_UID=DOCKER_UID DOCKER_GID=DOCKER_GID DOCKER_FULLNAME=DOCKER_USER /tmp/adduser.sh && \
    rm /tmp/adduser.sh && \
    echo '%sudo ALL=(ALL) NOPASSWD: ALL' | cat > /etc/sudoers.d/sudo
