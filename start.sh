#!/bin/bash

while  nc -z rabbitmq 5672; do
    echo "Waiting for rabbitmq..."
    sleep 3; done

sleep 60
echo "RabbitMQ endpoint: " ${RABBITMQ_PORT_5672_TCP_ADDR}:${RABBITMQ_PORT_5672_TCP_PORT}

node app.js 

