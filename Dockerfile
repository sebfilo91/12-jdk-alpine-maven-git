FROM openjdk:13-jdk-alpine

MAINTAINER Sebastien Phillot <sebastien.phillot@gmail.com>

ENV MAVEN_HOME=/usr/share/maven

RUN apk --no-cache add ca-certificates openssl git &&  update-ca-certificates

RUN cd /tmp \
   && wget https://archive.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz --no-check-certificate \
   && tar zxf apache-maven-3.6.0-bin.tar.gz \
   && rm -rf apache-maven-3.6.0-bin.tar.gz \
   && rm -rf *.sha1 \
   && mv ./apache-maven-3.6.0 /usr/share/maven \
   && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

