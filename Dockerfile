# Builds a docker image for the Confluent schema registry.
# Expects links to "kafka" and "zookeeper" containers.
#
# Usage:
#   docker build -t confluent/schema-registry schema-registry
#   docker run -d --name schema-registry --link zookeeper:zookeeper --link kafka:kafka \
#       --env SCHEMA_REGISTRY_AVRO_COMPATIBILITY_LEVEL=none confluent/schema-registry

FROM confluent/platform
ENV AWS_MSK_IAM_AUTH="1.1.1"

COPY schema-registry-docker.sh /usr/local/bin/

RUN wget https://github.com/aws/aws-msk-iam-auth/releases/download/v$AWS_MSK_IAM_AUTH/aws-msk-iam-auth-$AWS_MSK_IAM_AUTH-all.jar \
    && mv aws-msk-iam-auth-$AWS_MSK_IAM_AUTH-all.jar /usr/share/java/schema-registry/

#TODO Schema Registry needs a log directory.
RUN ["chown", "-R", "confluent:confluent", "/etc/schema-registry/schema-registry.properties"]
RUN ["chmod", "+x", "/usr/local/bin/schema-registry-docker.sh"]

EXPOSE 8081

USER confluent
ENTRYPOINT ["/usr/local/bin/schema-registry-docker.sh"]