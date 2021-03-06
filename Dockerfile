FROM develar/java:8u45

MAINTAINER scott

RUN apk add --update bash && rm -rf /var/cache/apk/*

ENV FLUME_VERSION 1.6.0
ENV FLUME_HOME /opt/lib/flume
ENV FLUME_AGENT_NAME a1
ENV FLUME_CONF_DIR /opt/lib/flume/conf
ENV FLUME_DATA_DIR /opt/lib/flume/data
ENV FLUME_CONF_FILE $FLUME_CONF_DIR/example.conf


RUN mkdir -p /opt/lib && \
    wget -q http://www.eu.apache.org/dist/flume/$FLUME_VERSION/apache-flume-$FLUME_VERSION-bin.tar.gz -O /opt/lib/apache-flume-$FLUME_VERSION-bin.tar.gz && \
    tar xzf /opt/lib/apache-flume-$FLUME_VERSION-bin.tar.gz -C /opt/lib && \
    mv /opt/lib/apache-flume-$FLUME_VERSION-bin /opt/lib/flume && \
    rm /opt/lib/apache-flume-$FLUME_VERSION-bin.tar.gz && \
    mv $FLUME_HOME/conf/flume-conf.properties.template $FLUME_HOME/conf/flume-conf.properties

VOLUME [ "/opt/lib/flume/conf" ]
VOLUME [ "/opt/lib/flume/data" ]
VOLUME [ "/opt/lib/java/bin" ]


COPY /bin /opt/lib/java/bin
COPY /conf /opt/lib/flume/conf
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 755 /docker-entrypoint.sh

ENV HADOOP_VERSION=2.7.2
ENV HADOOP_HOME=/opt/lib/hadoop-$HADOOP_VERSION

RUN wget -q http://www.eu.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz -O /opt/lib/hadoop-$HADOOP_VERSION.tar.gz && \
    tar xzf /opt/lib/hadoop-$HADOOP_VERSION.tar.gz -C /opt/lib && \
    rm /opt/lib/hadoop-$HADOOP_VERSION.tar.gz

#EXPOSE 8080

ENTRYPOINT ["/docker-entrypoint.sh" ]
