FROM node:4-onbuild
MAINTAINER Ewa Dadacz <ewa.dadacz@gmail.com>

RUN apt-get update && apt-get install -qq -y build-essential apt-transport-https ca-certificates libsystemd-journal0 netcat

# Create app directory
ENV INSTALL_PATH /usr/src/app
RUN mkdir -p $INSTALL_PATH

#WORKDIR $INSTALL_PATH
ENV AMQP_URI amqp://guest:guest@192.168.200.10
ENV SMTP_HOST smtp.gmail.com
ENV SMTP_PORT 465 
ENV SMTP_SSL false 
ENV SENDER_EMAIL sender-email@smpt.host  
ENV SMTP_USERNAME username
ENV SMTP_PASSWORD password

# Install app dependencies
COPY package.json $INSTALL_PATH
RUN npm install -g nodemon
RUN npm install

# Bundle app source
COPY . .

ADD start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
#CMD [ "node", "app.js"]
