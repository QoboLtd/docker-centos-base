FROM centos:centos7

LABEL org.label-schema.schema-version="1.0" \
    org.label-schema.name="CentOS Base Image" \
    org.label-schema.vendor="Qobo Ltd" \
    org.label-schema.livence="MIT" \
    org.label-schema.build-data="201806134"

MAINTAINER Qobo Ltd info@qobo.biz

# Enable Networking
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

# Install EPEL
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Install PHP and Tools 
RUN yum -y install --setopt=tsflags=nodocs git \
    openssh-clients \
    subversion \
    unzip \
    wget \
    zip \
    && yum clean all \
    && rm -rf /var/cache/yum

# Configure SSH for bitbucket and github hosts to be known
RUN mkdir ~/.ssh \
    && echo > ~/.ssh/known_hosts \
    && ssh-keyscan -t rsa bitbucket.com >> ~/.ssh/known_hosts \
    && ssh-keyscan -t rsa bitbucket.org >> ~/.ssh/known_hosts \
    && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts \
    && chmod -R u+rwX,go-rwX ~/.ssh

CMD ["/bin/bash"]
