FROM logstash:5.5.1

RUN logstash-plugin install logstash-filter-translate
RUN logstash-plugin install logstash-filter-jdbc_streaming
RUN logstash-plugin install logstash-output-google_bigquery

WORKDIR tmp/

RUN curl -L -s -o mysql-connector-java-5.1.43.tar.gz \
        https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.43.tar.gz && \
    tar zvxf mysql-connector-java-5.1.43.tar.gz && \
    mv mysql-connector-java-5.1.43/mysql-connector-java-5.1.43-bin.jar \
        /usr/share/logstash/lib/mysql-connector.jar
