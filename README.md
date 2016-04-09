# document-service
Demo of a Node microservice with an AMQP transport running on Docker

# Installation
1. Setup node environment (install npm)
2. Run "npm install"

# Running
Service requires an access to smtp server in order to send emails and rabbitmq to receive notifications. Configuration to these services is passed via environment variables:
- AMQP_URI - uri to amqp in form: amqp://user:password@host:port
- SMTP_HOST
- SMTP_PORT
- SMTP_SSL - true / 
- SMTP_USERNAME
- SMTP_PASSWORD
- SENDER_EMAIL

These env variables can be passed when running a node app. For instance:

<pre>AMQP_URI=amqp://test:test@192.168.200.10 SMTP_HOST=smtp.gmail.com SMTP_PORT=465 SMTP_USERNAME=secretpassword SMTP_PASSWORD=secretpassword SMTP_SSL=true SENDER_EMAIL=sender-email@smpt.host node app.js</pre>

# Running docker container
Service requires RabbitMQ. Both service and RabbitMQ run on separate containers. RabbitMQ container needs to be run first.

To run document-service and rabbitmq containers follow the steps: <br />
-  cd ../document-service/rabbitmq
-  docker build -t rabbitmq . (build rabbitmq docker image)
-  docker run -t -i -d -p 5672:5672 -p 15672:15672 --name rabbitmq rabbitmq  (run rabbitmq docker container)
-  cd ../document-service 
-  docker build -t document-service .
-  docker run -d -t -i -e AMQP_URI='amqp://guest:guest@192.168.200.10' -e SMTP_HOST='smtp.gmail.com' -e SMTP_USERNAME='username' -e SMTP_PASSWORD='secretpassword' -e SENDER_EMAIL='sender-email@smtp.host' --name document-service document-service (run document service container; pass environment variables with the flag '-e'; by default SMTP_PORT=465 and SMTP_SSL=false)
