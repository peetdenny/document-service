#!/bin/bash

while  nc -z rabbitmq 5672; do
    echo "Waiting for rabbitmq..."
    sleep 3; done

echo "RabbitMQ endpoint: " ${RABBITMQ_PORT_5672_TCP_ADDR}:${RABBITMQ_PORT_5672_TCP_PORT}

node app.js AMQP_URI=${AMQP_URI} SMTP_HOST=${SMTP_HOST} SMTP_PORT=${SMTP_PORT} SMTP_USERNAME=${SMTP_USERNAME} SMTP_PASSWORD=${SMTP_PASSWORD} SMTP_SSL=${SMTP_SSL} SENDER_EMAIL=${SENDER_EMAIL}
