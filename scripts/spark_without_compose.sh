#!/usr/bin/env bash

docker run -d --name master --net=spark-net --env="constraint:node==swarm-master" -p 4040:4040 -p 6066:6066 -p 7077:7077 -p 8080:8080 t3g7/docker-spark /usr/local/spark/bin/spark-class org.apache.spark.deploy.master.Master -h master

docker run -d --name slave --net=spark-net --env="constraint:node==swarm-node-01" -p 8081 t3g7/docker-spark /usr/local/spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://master:7077
