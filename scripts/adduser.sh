#!/usr/bin/env bash

set -x
set -e

if [[ -z $DOCKER_USER || -z $DOCKER_UID || -z $DOCKER_GID ]]; then
  echo "MISSING DOCKER_USER OR DOCKER_UID"
  exit 1;
fi

echo "adding $DOCKER_USER ($DOCKER_UID:$DOCKER_GID) to container"

# make the user group
/usr/sbin/groupadd -g $DOCKER_GID $DOCKER_USER > /dev/null 2>&1 || true

# make my user
# -l is required: https://github.com/docker/docker/issues/5419
/usr/sbin/useradd -l -d /home/$DOCKER_USER -s /usr/bin/fish -c "$DOCKER_USER" -g $DOCKER_GID -G sudo $DOCKER_USER -u $DOCKER_UID -p bogus > /dev/null 2>&1 || true

exit 0;
