FROM ubuntu:latest

COPY scripts/adduser.sh /tmp/adduser.sh

RUN mkdir -p /etc/salt/ && mkdir -p /srv/salt/base && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y  apt-utils vim emacs-nox emacs-goodies-el curl sudo bash tcsh zsh gnupg2 \
                        openssh-client openssh-server tmux git python3 salt-common salt-master salt-minion python-apt \
                        gcc g++ make python3-pip python3-venv python3-virtualenv ruby ruby-dev \
                        golang htop jq mtr && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get autoremove && \
    DOCKER_USER=DOCKER_USER DOCKER_UID=DOCKER_UID DOCKER_GID=DOCKER_GID DOCKER_FULLNAME=DOCKER_USER /tmp/adduser.sh && \
    rm /tmp/adduser.sh && \
    gem install -q fpm && \
    echo '%sudo ALL=(ALL) NOPASSWD: ALL' | cat > /etc/sudoers.d/sudo

COPY resources/etc/salt/minion /etc/salt/minion
