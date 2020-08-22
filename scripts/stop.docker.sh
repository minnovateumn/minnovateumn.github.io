#!/usr/bin/env zsh

source scripts_setup.sh

docker stop $(docker ps -a --filter name="${DOCKER_CONTAINER_NAME}" -q)
docker rm $(docker ps -a --filter name="${DOCKER_CONTAINER_NAME}" -q)
