# Spark cluster deployer [![Build Status](https://travis-ci.org/t3g7/spark-cluster-deploy.svg?branch=master)](https://travis-ci.org/t3g7/spark-cluster-deploy) [![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://registry.hub.docker.com/u/t3g7/docker-spark/)

Apache Spark image in a Docker container, based on ```ubuntu:15.04```. Cluster deployed with Docker Compose and orchestrated with Docker Swarm.

Heavily inspired by [gettyimages/docker-spark](https://github.com/gettyimages/docker-spark).

## Build the image

To make it work for Swarm later, the image must be built and pushed to the Docker Hub.
Travis CI automatically does this step so the the image should already be available at [t3g7/docker-spark](https://hub.docker.com/r/t3g7/docker-spark/).

Pull the built image from the Docker Hub:

	docker pull t3g7/docker-spark

#### In case of emergency (do it yourself)

First build from the Dockerfile with:

	docker build -t t3g7/docker-spark .

Then push it to the Docker Hub:

	docker push t3g7/docker-spark

## Create the Swarm cluster

First, create a token used later on:

	docker run swarm create

### On a cloud provider

We will use the Digital Ocean driver.

Create the master node - DO_ACCESS_TOKEN is the token you can get from your account at Digital Ocean and SWARM_TOKEN is the token previously created.

	docker-machine create \
		--driver digitalocean \
		--digitalocean-access-token $DO_ACCESS_TOKEN \
		--digitalocean-image "ubuntu-15-04-x64" \
		--digitalocean-region "fra1" \
		--digitalocean-size "2gb" \
		--digitalocean-private-networking \
		--swarm \
		--swarm-master \
		--swarm-discovery token://$SWARM_TOKEN \
		swarm-master

Then create slave nodes:

	for i in $(seq 1 $NUMBER_OF_NODES); do
	docker-machine create \
		--driver digitalocean \
		--digitalocean-access-token $DO_ACCESS_TOKEN \
		--digitalocean-image "ubuntu-15-04-x64" \
		--digitalocean-region "fra1" \
		--digitalocean-size "2gb" \
		--digitalocean-private-networking \
		--swarm \
		--swarm-discovery token://$SWARM_TOKEN \
		swarm-node-$i;
	done;

### Locally on VirtualBox

Similarly, create the master node:

	docker-machine create \
		--driver virtualbox \
		--swarm \
		--swarm-master \
		--swarm-discovery token://$SWARM_TOKEN \
		swarm-master

 and slave nodes:

	docker-machine create \
		--driver virtualbox \
		--swarm \
		--swarm-discovery token://$SWARM_TOKEN \
		swarm-node-01

### After creating the nodes

Connect to the Swarm master with:

	eval $(docker-machine env --swarm swarm-master)

The cluster configuration should be visible by running:

	docker info

## Deploy the containers

Run ```docker-compose up -d``` and ```docker-compose scale slave=$NUMBER_OF_SPARK_WORKERS``` to deploy the containers and scale them.

## Use Spark

For example, run the shell:

	docker exec -it master /bin/bash /usr/local/spark/bin/pyspark --master spark://master:7077

## To do

What do we want ? Multi-Host Networking with Swarm and Compose !
Issue : after deployment, all the containers should exist on the same Swarm node because linked containers are always scheduled on the same host by Docker Compose for now. Docker Swarm is still in development and containers are not able to talk to each other across nodes.

- Solution still experimental: https://github.com/docker/docker/blob/v1.8.3/experimental/compose_swarm_networking.md
- Coming to 1.9.0: https://github.com/docker/docker/releases/tag/v1.9.0-rc4
