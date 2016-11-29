FROM registry.access.redhat.com/rhel7:latest
MAINTAINER John Osborne "josborne@redhat.com"

ENV SA_PASSWORD=redhat1!
ENV container docker

RUN yum install yum-utils -y
RUN yum-config-manager --enable rhel-6-server-rpms rhel-server-rhscl-7-rpms rhel-6-server-supplementary-rpms &> /dev/null
RUN yum install sudo sysvinit-tools wget -y
RUN yum update -y

RUN wget -O /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server.repo
RUN yum install -y mssql-server
RUN yum clean all

RUN /opt/mssql/bin/sqlservr-setup --accept-eula --set-sa-password --start-service --enable-service

STOPSIGNAL SIGRTMIN+3

EXPOSE 1433
CMD [ "/sbin/init" ]
