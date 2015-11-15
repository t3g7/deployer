#!/usr/bin/env bash

# Create the swarm master
docker-machine create \
	-d virtualbox \
	--swarm --swarm-image="swarm" --swarm-master \
	--swarm-discovery="consul://$(docker-machine ip mh-keystore):8500" \
	--engine-opt="cluster-store=consul://$(docker-machine ip mh-keystore):8500" \
	--engine-opt="cluster-advertise=eth1:2376" \
	swarm-master

# And a swarm slave
docker-machine create \
	-d virtualbox \
	--swarm --swarm-image="swarm:latest" \
        --swarm-discovery="consul://$(docker-machine ip mh-keystore):8500" \
	--engine-opt="cluster-store=consul://$(docker-machine ip mh-keystore):8500" \
	--engine-opt="cluster-advertise=eth1:2376" \
	swarm-node-01
