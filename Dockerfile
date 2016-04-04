FROM node:4-onbuild
MAINTAINER Ewa Dadacz <ewa.dadacz@gmail.com>

RUN apt-get update && apt-get install -qq -y build-essential apt-transport-https ca-certificates libsystemd-journal0

# Create app directory
ENV INSTALL_PATH /usr/src/document-service
RUN mkdir -p $INSTALL_PATH


WORKDIR $INSTALL_PATH
ENV AMQP_URI amqp://test:test@172.30.0.206
ENV SMTP_HOST smtp.gmail.com 
ENV SMTP_PORT 465 
ENV SMTP_SSL true 
ENV SENDER_EMAIL sender-email@smpt.host 
ENV SENDER_PASSWORD secretpassword

# Install app dependencies
COPY package.json $INSTALL_PATH
RUN npm install -g nodemon
RUN npm install

# Bundle app source
COPY . .

EXPOSE 3000
CMD [ "nodemon", "$INSTALL_PATH/app.js", "$AMQP_URI", "$SMTP_HOST", "$SMTP_PORT", "$SMTP_SSL", "$SENDER_EMAIL", "$SENDER_PASSWORD"]
