# base image
from debian:buster-slim
USER root
ENV DEBIAN_FRONTEND=noninteractive
RUN mkdir -p /usr/share/man/man1 /usr/share/man/man2
RUN apt-get update && \
apt-get install -y --no-install-recommends \
       openjdk-11-jre
           
#Prints installed java version, just for checking
RUN java --version

#install npm
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nodejs \
    npm                       # note this one
    
# We need wget to set up the PPA and xvfb to have a virtual screen and unzip to install the Chromedriver
RUN apt-get install -y wget xvfb unzip
RUN apt-get install -y mailutils

#install chrome for protractor tests
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -yq google-chrome-stable

# set working directory
RUN pwd
RUN ls
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH
ENV REST_HOST=$REST_HOST
ENV REST_PORT=$REST_PORT

# install and cache app dependencies
#RUN pwd
#RUN ls
COPY package.json /app/package.json
RUN npm install -g protractor
#RUN pwd
#RUN ls
COPY . /app
#RUN ls -lh
#change permissions for webdriver-update
RUN chmod -R 777 ./
#RUN java --version
#RUN ls -l
RUN webdriver-manager update
RUN npm test

WORKDIR ./Reports
#RUN ls -lh
COPY 2020-12-20.html /var/lib/jenkins/workspace/FEI_PetClinic_uiAutoXX/Reports/
#RUN echo "Protractor report" | mail -s "Protractor Report Here" tathe.prashant@gmail.com -A 2020-12-20.html
RUN pwd

# add app
