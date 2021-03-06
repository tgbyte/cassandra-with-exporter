FROM cassandra

ENV JMX_PROMETHEUS_JAVA_AGENT_VERSION=0.1.0

ADD http://central.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${JMX_PROMETHEUS_JAVA_AGENT_VERSION}/jmx_prometheus_javaagent-${JMX_PROMETHEUS_JAVA_AGENT_VERSION}.jar /usr/app/jmx_prometheus_javaagent.jar
ADD prometheus-config.yml /usr/app/prometheus-config.yml

EXPOSE 31500

RUN chmod +r /usr/app/jmx_prometheus_javaagent.jar \
 && echo 'JVM_OPTS="$JVM_OPTS -javaagent:/usr/app/jmx_prometheus_javaagent.jar=${PROMETHEUS_PORT:-31500}:/usr/app/prometheus-config.yml"' >> /etc/cassandra/cassandra-env.sh
