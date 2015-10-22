# Apache Spark cluster deployer

Apache Spark in a Docker container, based on ``` ubuntu:15.04 ```.

## Commands

Building the Docker image from the Dockerfile:

	docker build -t docker-spark .

or pull the built image from DockerHub:

	docker pull eftov/docker-spark

Run the pyspark shell with:

	docker run -it -p 4040:4040 eftov/docker-spark /bin/bash /usr/local/spark/bin/pyspark

The job is running at ``` http://$DOCKER_HOST_IP:4040 ```
