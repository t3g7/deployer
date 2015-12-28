#!/usr/bin/env bash

eval $(docker-machine env --swarm swarm-master)
docker network create --driver overlay spark-net
