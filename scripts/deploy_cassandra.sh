#!/usr/bin/env bash

docker run --name cass1 -d -e CASSANDRA_BROADCAST_ADDRESS=$(docker-machine ip swarm-node-1) -e "constraint:node==swarm-node-1" -p 7000:7000 cassandra:2.2.4

docker run --name cass2 -d -e CASSANDRA_BROADCAST_ADDRESS=$(docker-machine ip swarm-node-2) -p 7000:7000 -e CASSANDRA_SEEDS=$(docker-machine ip swarm-node-1) -e "constraint:node==swarm-node-2" cassandra:2.2.4

docker run --name cass3 -d -e CASSANDRA_BROADCAST_ADDRESS=$(docker-machine ip swarm-node-3) -p 7000:7000 -e CASSANDRA_SEEDS=$(docker-machine ip swarm-node-1) -e "constraint:node==swarm-node-3" cassandra:2.2.4

docker run -it --rm --net container:cass1 cassandra:2.2.4 nodetool status
