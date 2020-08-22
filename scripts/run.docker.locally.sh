#!/usr/bin/env zsh

source scripts_setup.sh

if [ "$#" -lt 1 ]; then
    echo "*** Error: you must supply a script mode: 'build', 'props', or 'run'"
    exit 1
fi

ARG=$1
shift

if [[ "$ARG" == "build" ]]; then
    echo "*** Note: 'build' was supplied so cleaning then building ..."
elif [[ "$ARG" == "props" ]]; then
    echo "*** Note: 'props' was supplied so just updating properties then running ..."
elif [[ "$ARG" == "run" ]]; then
    echo "*** Note: 'run' was supplied so just running ..."
fi

# create bridged docker network so localhost is visible to docker container as 192.168.0.1
docker network create -d bridge --subnet 192.168.0.0/24 --gateway 192.168.0.1 dockernet

export START_DATE=$(date '+%Y-%m-%d_%H-%M-%S')
export DOCKER_CONTAINER_NAME="${DOCKER_CONTAINER_NAME}_${START_DATE}"

docker build --no-cache -f ../Dockerfile -t $DOCKER_CONTAINER_NAME:1 ../

docker run -d \
	--restart=on-failure \
	--net=dockernet \
	-p 8080:4000 \
	--name $DOCKER_CONTAINER_NAME \
	-t $DOCKER_CONTAINER_NAME:1
