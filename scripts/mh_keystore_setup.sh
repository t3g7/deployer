#!/usr/bin/env bash

# https://docs.docker.com/engine/userguide/networking/get-started-overlay

docker-machine create -d virtualbox mh-keystore
docker $(docker-machine config mh-keystore) run -d \
  -p "8500:8500" \
  -h "consul" \
  progrium/consul -server -bootstrap

eval "$(docker-machine env mh-keystore)"
