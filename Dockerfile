FROM node:4-onbuild
MAINTAINER Ewa Dadacz <ewa.dadacz@gmail.com>

RUN apt-get update && apt-get install -qq -y build-essential apt-transport-https ca-certificates libsystemd-journal0

# Create app directory
ENV INSTALL_PATH /usr/src/app
RUN mkdir -p $INSTALL_PATH

#WORKDIR $INSTALL_PATH
ENV AMQP_URI amqp://guest:guest@172.30.0.206
ENV SMTP_HOST email-smtp.eu-west-1.amazonaws.com 
ENV SMTP_PORT 465 
ENV SMTP_SSL false 
# username serviceuser
ENV SENDER_EMAIL sender-email@smpt.host  
# ENV SENDER_PASSWORD secretpassword
ENV SMTP_USERNAME username
ENV SMTP_PASSWORD password

# Install app dependencies
COPY package.json $INSTALL_PATH
RUN npm install -g nodemon
RUN npm install

# Bundle app source
COPY . .

# EXPOSE 8080
CMD [ "node", "app.js", "$AMQP_URI", "$SMTP_HOST", "$SMTP_PORT", "$SMTP_USERNAME", "$SMTP_PASSWORD",  "$SMTP_SSL", "$SENDER_EMAIL"]
