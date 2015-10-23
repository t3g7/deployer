# Spark cluster deployer [![Build Status](https://travis-ci.org/t3g7/spark-cluster-deploy.svg?branch=master)](https://travis-ci.org/t3g7/spark-cluster-deploy) [![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://registry.hub.docker.com/u/t3g7/docker-spark/)

Apache Spark in a Docker container, based on ``` ubuntu:15.04 ```.

## Commands

Building the Docker image from the Dockerfile:

	docker build -t docker-spark .

or pull the built image from DockerHub:

	docker pull t3g7/docker-spark

Run the pyspark shell with:

	docker run -it -p 4040:4040 t3g7/docker-spark /bin/bash /usr/local/spark/bin/pyspark

The job is running at ``` http://$DOCKER_HOST_IP:4040 ```
