FROM node:4-onbuild
MAINTAINER Ewa Dadacz <ewa.dadacz@gmail.com>

RUN apt-get update && apt-get install -qq -y build-essential apt-transport-https ca-certificates libsystemd-journal0

# Create app directory
ENV INSTALL_PATH /usr/src/advice-service
RUN mkdir -p $INSTALL_PATH


WORKDIR $INSTALL_PATH

# Install app dependencies
COPY package.json $INSTALL_PATH
RUN npm install -g nodemon
RUN npm install express
RUN npm install body-parser
RUN npm install logger
RUN npm install winston
RUN npm install amqplib



# Bundle app source
COPY . .

EXPOSE 3000
CMD [ "nodemon", "$INSTALL_PATH/app.js", "amqp://user:password@host:port"]

