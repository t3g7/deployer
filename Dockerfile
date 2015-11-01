FROM ubuntu:15.04
MAINTAINER Benjamin Fovet @eftov <b.fovet@gmail.com>

RUN apt-get -y update && apt-get install -y \
    python \
    scala \
    wget

# Java
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get -y update
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN apt-get install -y \
    oracle-java8-installer \
    oracle-java8-set-default
ENV JAVA_HOME "/usr/lib/jvm/java-8-oracle"

# Spark
RUN wget -qO- http://d3kbcqa49mib13.cloudfront.net/spark-1.5.1-bin-hadoop2.6.tgz \
    | tar xvz \
    && mv spark-1.5.1-bin-hadoop2.6 /usr/local/spark
ENV SPARK_VERSION 1.5.1
ENV SPARK_HOME "/usr/local/spark"
ENV PATH $PATH:$SPARK_HOME/bin

CMD ["/usr/local/spark/bin/spark-class", "org.apache.spark.deploy.master.Master"]
