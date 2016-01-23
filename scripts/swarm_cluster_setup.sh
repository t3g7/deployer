#!/usr/bin/env bash

# Create the swarm master
docker-machine create \
  -d virtualbox \
  --virtualbox-memory "2048" \
  --virtualbox-cpu-count "2" \
  --swarm --swarm-image="swarm" --swarm-master \
  --swarm-discovery="consul://$(docker-machine ip mh-keystore):8500" \
  --engine-opt="cluster-store=consul://$(docker-machine ip mh-keystore):8500" \
  --engine-opt="cluster-advertise=eth1:2376" \
  swarm-master

# Create 3 swarm slaves
for i in {1..3}
do
  docker-machine create \
    -d virtualbox \
    --virtualbox-memory "2048" \
    --virtualbox-cpu-count "2" \
    --swarm --swarm-image="swarm:latest" \
    --swarm-discovery="consul://$(docker-machine ip mh-keystore):8500" \
    --engine-opt="cluster-store=consul://$(docker-machine ip mh-keystore):8500" \
    --engine-opt="cluster-advertise=eth1:2376" \
    swarm-node-$i
done

# Digital Ocean setup
#  docker-machine create \
#    --driver digitalocean \
#    --digitalocean-access-token $DO_ACCESS_TOKEN \
#    --digitalocean-image "ubuntu-15-04-x64" \
#    --digitalocean-region "fra1" \
#    --digitalocean-size "2gb" \
#    --digitalocean-private-networking \
#    --swarm \
#    --swarm-master \
#    --swarm-discovery token://$SWARM_TOKEN \
#    swarm-master

#  for i in $(seq 1 $NUMBER_OF_NODES); do
#  docker-machine create \
#    --driver digitalocean \
#    --digitalocean-access-token $DO_ACCESS_TOKEN \
#    --digitalocean-image "ubuntu-15-04-x64" \
#    --digitalocean-region "fra1" \
#    --digitalocean-size "2gb" \
#    --digitalocean-private-networking \
#    --swarm \
#    --swarm-discovery token://$SWARM_TOKEN \
#    swarm-node-$i;
#  done;
