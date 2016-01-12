#!/usr/bin/env bash

echo "Deploying container cass1 on swarm-node-1"
docker run --name cass1 -d \
  -e CASSANDRA_BROADCAST_ADDRESS=$(docker-machine ip swarm-node-1) \
  -e "constraint:node==swarm-node-1" \
  -p 7000:7000 \
  cassandra:2.2.4

echo "Deploying container cass2 on swarm-node-2"
docker run --name cass2 -d \
  -e CASSANDRA_BROADCAST_ADDRESS=$(docker-machine ip swarm-node-2) \
  -e CASSANDRA_SEEDS=$(docker-machine ip swarm-node-1) \
  -e "constraint:node==swarm-node-2" \
  -p 7000:7000 \
  cassandra:2.2.4

echo "Deploying container cass3 on swarm-node-3"
docker run --name cass3 -d \
  -e CASSANDRA_BROADCAST_ADDRESS=$(docker-machine ip swarm-node-3) \
  -e CASSANDRA_SEEDS=$(docker-machine ip swarm-node-1) \
  -e "constraint:node==swarm-node-3" \
  -p 7000:7000 \
  cassandra:2.2.4

echo "Waiting for the cluster to be completely up..."
sleep 15
docker run -it --rm --net container:cass1 cassandra:2.2.4 nodetool status
