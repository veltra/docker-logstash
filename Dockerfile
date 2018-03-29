FROM docker.elastic.co/logstash/logstash:6.2.3

RUN logstash-plugin install logstash-filter-translate
RUN logstash-plugin install logstash-filter-jdbc_streaming
RUN logstash-plugin install logstash-output-google_bigquery

WORKDIR tmp/

RUN curl -L -s -o mysql-connector-java-5.1.46.tar.gz \
        https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.46.tar.gz && \
    tar zvxf mysql-connector-java-5.1.46.tar.gz && \
    mv mysql-connector-java-5.1.46/mysql-connector-java-5.1.46-bin.jar \
        /usr/share/logstash/lib/mysql-connector.jar
