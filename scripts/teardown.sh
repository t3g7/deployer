#!/usr/bin/env bash

for i in {1..3}
do
  docker-machine rm swarm-node-$i
done

docker-machine rm swarm-master
docker-machine rm mh-keystore
