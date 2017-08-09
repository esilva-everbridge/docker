export DOCKER_USER=${USER}
export DOCKER_UID=$(shell id -u)
export DOCKER_GID=$(shell id -g)
export SHELL="/bin/bash"

Dockerfile : Dockerfile.sed
	@sed -e "s/=DOCKER_USER/=$(DOCKER_USER)/g" -e "s/=DOCKER_UID/=$(DOCKER_UID)/" -e "s/=DOCKER_GID/=$(DOCKER_GID)/" Dockerfile.sed > Dockerfile

build : Dockerfile scripts/adduser.sh
	@echo "building docker container..."
	@docker build --rm=true -t ubuntu:$(DOCKER_USER) .

run : build
	@echo "running docker container..."
	@docker run -v /Users/${DOCKER_USER}:/home/${DOCKER_USER} -w /home/${DOCKER_USER} --env "HOME=/home/${DOCKER_USER}" -i -t ubuntu:$(DOCKER_USER) /bin/su - ${DOCKER_USER}

run-root : build
	@echo "running as root in docker container..."
	@docker run -v /Users/${DOCKER_USER}:/home/${DOCKER_USER} -w /home/${DOCKER_USER} -i -t ubuntu:$(DOCKER_USER) /bin/bash

clean :
	@rm Dockerfile || true
