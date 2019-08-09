FROM openjdk:13-jdk-alpine

MAINTAINER Sebastien Phillot <sebastien.phillot@gmail.com>

ENV MAVEN_HOME=/usr/share/maven
ENV HELM_VERSION="v2.13.1"
ENV KUBE_LATEST_VERSION="v1.14.3"

RUN apk --no-cache add ca-certificates openssh openssh-client openssl git curl bash &&  update-ca-certificates

RUN cd /tmp \
   && wget https://archive.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz --no-check-certificate \
   && tar zxf apache-maven-3.6.0-bin.tar.gz \
   && rm -rf apache-maven-3.6.0-bin.tar.gz \
   && mv ./apache-maven-3.6.0 /usr/share/maven \
   && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn \
   && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
   && chmod +x /usr/local/bin/kubectl \
   && wget -q https://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
   && chmod +x /usr/local/bin/helm

RUN chmod a+rwx /home/jenkins

WORKDIR /home/jenkins

USER jenkins

