# Spark Cassandra cluster deployment scripts

[![Build Status](https://travis-ci.org/t3g7/deployer.svg?branch=master)](https://travis-ci.org/t3g7/deployer) [![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://registry.hub.docker.com/u/t3g7/docker-spark/)

Apache Spark in a Docker container, based on `java:8`. Heavily inspired by [gettyimages/docker-spark](https://github.com/gettyimages/docker-spark). Cluster deployed with Docker Compose and orchestrated with Docker Swarm.

Official image for [Cassandra](https://hub.docker.com/_/cassandra/) is used and installed on the same nodes as Spark slaves.

### Run the cluster locally on VirtualBox

In `scripts/`, run :

	./bootstrap.sh

This script will set up a key-value store using Consul, a Swarm cluster with a master and a slave, and an overlay network for multi-host networking.

### After creating the nodes

Connect to the Swarm master with:

	eval $(docker-machine env --swarm swarm-master)

The cluster configuration should be visible by running:

	docker info

## Deploy Spark

Deploy the containers on constrained nodes with:

	docker-compose --x-networking --x-network-driver=overlay up -d

## Deploy Cassandra

This script takes around 20 minutes to finish.
In `scripts/`, run:

	./deploy_cassandra.sh

## References

- Multi-host networking: https://docs.docker.com/engine/userguide/networking/get-started-overlay/
- Networking in Compose: https://docs.docker.com/compose/networking/
