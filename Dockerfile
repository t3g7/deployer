FROM java:8
MAINTAINER Benjamin Fovet @eftov

RUN apt-get -y update && apt-get install -y \
    python \
    scala \
    wget

RUN wget -qO- http://d3kbcqa49mib13.cloudfront.net/spark-1.5.1-bin-hadoop2.6.tgz \
    | tar xvz \
    && mv spark-1.5.1-bin-hadoop2.6 /usr/local/spark
ENV SPARK_VERSION 1.5.1
ENV SPARK_HOME "/usr/local/spark"
ENV PATH $PATH:$SPARK_HOME/bin

CMD ["/usr/local/spark/bin/spark-class", "org.apache.spark.deploy.master.Master"]
