# Spark cluster deployer [![Build Status](https://travis-ci.org/t3g7/spark-cluster-deploy.svg?branch=master)](https://travis-ci.org/t3g7/spark-cluster-deploy) [![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://registry.hub.docker.com/u/t3g7/docker-spark/)

Apache Spark image in a Docker container, based on `ubuntu:15.04`. Cluster deployed with Docker Compose and orchestrated with Docker Swarm.

Heavily inspired by [gettyimages/docker-spark](https://github.com/gettyimages/docker-spark).

### Run the cluster locally on VirtualBox

In `scripts`, run :

	./bootstrap.sh

This script will set up a key-value store using Consul, a Swarm cluster with a master and a slave, and an overlay network for multi-host networking.

### After creating the nodes

Connect to the Swarm master with:

	eval $(docker-machine env --swarm swarm-master)

The cluster configuration should be visible by running:

	docker info

## Deploy the containers

### With Docker Compose

Deploy the containers on constrained nodes with:

	docker-compose --x-networking --x-network-driver=overlay up -d 
	
Use the `scale` option to add more Spark workers:

	docker-compose scale slave=$NUMBER_OF_SPARK_WORKERS

### Without Compose (to be tested)

Start the master :

	docker run -d --name master --net=spark-net --env="constraint:node==swarm-master" -p 4040:4040 -p 6066:6066 -p 7077:7077 -p 8080:8080 t3g7/docker-spark /usr/local/spark/bin/spark-class org.apache.spark.deploy.master.Master -h master

Start the slave :

	docker run -d --name slave --net=spark-net --env="constraint:node==swarm-node-01" -p 8081 t3g7/docker-spark /usr/local/spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://master:7077

## Use Spark

For example, run the shell:

	docker exec -it master /bin/bash /usr/local/spark/bin/pyspark --master spark://master:7077

## References

- Multi-host networking: https://docs.docker.com/engine/userguide/networking/get-started-overlay/
- Networking in Compose: https://docs.docker.com/compose/networking/
