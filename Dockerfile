# base image
#FROM node:latest
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

# Set up the Chrome PPA
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Update the package list and install chrome
RUN apt-get update -y
RUN apt-get install -y google-chrome-stable

# Download and install Chromedriver
RUN wget -q --continue -P $CHROMEDRIVER_DIR "http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
RUN unzip $CHROMEDRIVER_DIR/chromedriver* -d $CHROMEDRIVER_DIR

# Put Chromedriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH
#ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV REST_HOST=$REST_HOST
ENV REST_PORT=$REST_PORT

# install and cache app dependencies
COPY package.json /app/package.json
RUN npm install -g protractor
#RUN pwd
#RUN df -h
COPY . /app
RUN ls -lh
#RUN rm -r protractorui
#RUN ps -aux
#RUN pkill chrome
RUN chmod -R 777 ./
RUN java --version
#RUN ls -l
RUN webdriver-manager update
RUN npm test


# add app
