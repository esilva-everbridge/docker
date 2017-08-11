FROM ubuntu:latest

COPY scripts/adduser.sh /tmp/adduser.sh

RUN mkdir -p /etc/salt/ && mkdir -p /srv/salt/base && \
    apt-get update && \
    apt-get install -y  apt-utils vim emacs-nox curl sudo bash tcsh zsh gnupg2 \
                        openssh-client openssh-server tmux git python3 salt-minion python-apt && \
    apt-get update && \
    DOCKER_USER=DOCKER_USER DOCKER_UID=DOCKER_UID DOCKER_GID=DOCKER_GID DOCKER_FULLNAME=DOCKER_USER /tmp/adduser.sh && \
    rm /tmp/adduser.sh && \
    echo '%sudo ALL=(ALL) NOPASSWD: ALL' | cat > /etc/sudoers.d/sudo

COPY resources/etc/salt/minion /etc/salt/minion
