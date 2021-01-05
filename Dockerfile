# chromium > 76 is required. For now, this is only available in the 'edge' build
FROM alpine:edge
USER root

RUN apk add openjdk11 
RUN java --version

#install npm
RUN apk add  --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.7/main/ nodejs=8.9.3-r1

#insttall firefox
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing firefox
	
WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH
ENV REST_HOST=$REST_HOST
ENV REST_PORT=$REST_PORT
#Global npm dependencies
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
#optionally if you want to run npm global bin without specifying path
ENV PATH=$PATH:/home/node/.npm-global/bin

COPY package.json /app/package.json
RUN npm install -g
COPY . /app
RUN chmod -R 777 ./
RUN webdriver-manager update
RUN npm test

# add app
