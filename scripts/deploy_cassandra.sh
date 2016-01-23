#!/usr/bin/env bash

echo "Deploying container cass1 on swarm-node-1"
docker run --name cass1 -d \
  -h cass1 \
  -e CASSANDRA_BROADCAST_ADDRESS=$(docker-machine ip swarm-node-1) \
  -e CASSANDRA_RPC_ADDRESS=0.0.0.0 \
  -e CASSANDRA_START_RPC=true \
  -e "constraint:node==swarm-node-1" \
  -v /data:/var/lib/cassandra \
  -p 7000:7000 \
  -p 9042:9042 \
  cassandra:2.2.4

echo "Deploying container cass2 on swarm-node-2"
docker run --name cass2 -d \
  -h cass2 \
  -e CASSANDRA_BROADCAST_ADDRESS=$(docker-machine ip swarm-node-2) \
  -e CASSANDRA_RPC_ADDRESS=0.0.0.0 \
  -e CASSANDRA_START_RPC=true \
  -e CASSANDRA_SEEDS=$(docker-machine ip swarm-node-1) \
  -e "constraint:node==swarm-node-2" \
  -v /data:/var/lib/cassandra \
  -p 7000:7000 \
  -p 9042:9042 \
  cassandra:2.2.4

echo "Deploying container cass3 on swarm-node-3"
docker run --name cass3 -d \
  -h cass3 \
  -e CASSANDRA_BROADCAST_ADDRESS=$(docker-machine ip swarm-node-3) \
  -e CASSANDRA_RPC_ADDRESS=0.0.0.0 \
  -e CASSANDRA_START_RPC=true \
  -e CASSANDRA_SEEDS=$(docker-machine ip swarm-node-1) \
  -e "constraint:node==swarm-node-3" \
  -v /data:/var/lib/cassandra \
  -p 7000:7000 \
  -p 9042:9042 \
  cassandra:2.2.4

echo "Waiting for the cluster to be completely up..."
sleep 30
docker run -it --rm --net container:cass1 cassandra:2.2.4 nodetool status
