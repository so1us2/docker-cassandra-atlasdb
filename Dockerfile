FROM cassandra:2.2.9

RUN apt-get update && apt-get install ca-certificates && update-ca-certificates
RUN apt-get install -y curl
RUN curl -Lk https://bintray.com/palantir/releases/download_file?file_path=com%2Fpalantir%2Fcassandra%2Fpalantir-cassandra%2F2.2.13-1.0.0-rc1%2Fpalantir-cassandra-2.2.13-1.0.0-rc1.tgz > p-cass.tgz
RUN tar -zxvf p-cass.tgz
ENV CASSANDRA_COMMAND palantir-cassandra-2.2.13-1.0.0-rc1/bin/cassandra

ENV _JAVA_OPTIONS=-Dcassandra.skip_wait_for_gossip_to_settle=0
ENV CASSANDRA_CONFIG /etc/cassandra
ENV CASSANDRA_YAML $CASSANDRA_CONFIG/cassandra.yaml
ENV CASSANDRA_ENV $CASSANDRA_CONFIG/cassandra-env.sh

COPY cassandra.yaml $CASSANDRA_YAML
COPY cassandra-env.sh $CASSANDRA_ENV
COPY entrypoint.sh /entrypoint.sh

EXPOSE 7000 7001 7199 9042 9160

ENTRYPOINT ["/entrypoint.sh"]
CMD ["palantir-cassandra-2.2.13-1.0.0-rc1/bin/cassandra", "-f"]
