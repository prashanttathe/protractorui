# chromium > 76 is required. For now, this is only available in the 'edge' build
FROM alpine:edge

USER root

#config SSMTP
RUN apk update
RUN apk add ssmtp
EXPOSE 9000

RUN apk add openjdk11 
RUN java --version

#install npm
#RUN apk update && apk upgrade -y && \
 #   apk add -y nodejs \
  #  npm                       # note this one
RUN apk add  --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.7/main/ nodejs=8.9.3-r1
    
#RUN \
#add-pkg --repository http://dl-cdn.alpinelinux.org/alpine/edge/community
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing firefox
	
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH
ENV REST_HOST=$REST_HOST
ENV REST_PORT=$REST_PORT
#Global npm dependencies
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
#optionally if you want to run npm global bin without specifying path
ENV PATH=$PATH:/home/node/.npm-global/bin

#User root
# install and cache app dependencies
#RUN pwd
RUN ls -lh
COPY package.json /app/package.json

RUN npm install -g
#RUN pwd
#RUN ls
COPY . /app
#RUN ls -lh
#change permissions for webdriver-update
RUN chmod -R 777 ./
#RUN java --version
#RUN ls -l
RUN webdriver-manager update
#RUN chmod -R 777 /app/node_modules
RUN npm test
WORKDIR ./reports
RUN ls -lh
#RUN cat 2020-12-24.html
#RUN echo "Protractor report" | mail -s "Protractor Report Here" tathe.prashant@gmail.com -A 2020-12-24.html
#RUN pwd
VOLUME /reports
COPY ./reports/2020-12-24.html /reports
# add app
