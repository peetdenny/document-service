# USE UBUNTU
FROM ubuntu:trusty

MAINTAINER Ewa Dadacz <ewa.dadacz@gmail.com>

# INSTALL RABBITMQ
RUN apt-get -qq update && apt-get install -qq -y rabbitmq-server

# ENABLE MANAGEMENT INTERFACE
RUN rabbitmq-plugins enable rabbitmq_management

#COPY CONFIG FILE
ADD rabbitmq.config /etc/rabbitmq/rabbitmq.config

# EXPOSE RABBITMQ PORT AND MANAGEMENT UI PORT
EXPOSE 5672 15672

# SET THE CONTAINER ENTRYPOINT TO THE RABBITMQ EXECUTABLE
ENTRYPOINT /usr/sbin/rabbitmq-server
