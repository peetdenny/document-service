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
- SMTP_SSL - true / false
- SENDER_EMAIL
- SENDER_PASSWORD

These env variables can be passed when running a node app. For instance:
<code>AMQP_URI=amqp://test:test@192.168.200.10 SMTP_HOST=smtp.gmail.com SMTP_PORT=465 SMTP_SSL=true SENDER_EMAIL=sender-email@smpt.host SENDER_PASSWORD=secretpassword node app.js</code>
