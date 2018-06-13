FROM centos:centos7

LABEL org.label-schema.schema-version="1.0" \
    org.label-schema.name="CentOS Base Image" \
    org.label-schema.vendor="Qobo Ltd" \
    org.label-schema.livence="MIT" \
    org.label-schema.build-data="20180613"

ARG uid=1000
ARG gid=1000

ENV container docker

# UTC Timezone
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# Enable Networking
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

# Install EPEL
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

# Install PHP and Tools 
RUN yum -y install ack \
    bash-completion \
    bind-utils \
    git \
    grep \
    htop \
    links \
    mc \
    mtr \
    openssh-clients \
    screen \
    strace \
    subversion \
    telnet \
    tig \
    tree \
    unzip \
    vim-enhanced \
    wget \
    zip

# Configure SSH for bitbucket and github hosts to be known
RUN mkdir ~/.ssh \
    && echo > ~/.ssh/known_hosts \
    && ssh-keyscan -t rsa bitbucket.com >> ~/.ssh/known_hosts \
    && ssh-keyscan -t rsa bitbucket.org >> ~/.ssh/known_hosts \
    && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts \
    && chmod -R u+rwX,go-rwX ~/.ssh

CMD ["/bin/bash"]
