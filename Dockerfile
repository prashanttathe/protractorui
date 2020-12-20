# base image
FROM node:latest
#RUN sudo shutdown -r now
#RUN pwd
#RUN df -h
#RUN ls -lh

# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer
  
#install chrome for protractor tests
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -yq google-chrome-stable

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV REST_HOST=$REST_HOST
ENV REST_PORT=$REST_PORT

# install and cache app dependencies
COPY package.json /app/package.json
RUN npm install -g protractor
#RUN pwd
#RUN df -h
COPY . /app
#RUN ls -lh
#RUN rm -r protractorui
#RUN ps -aux
#RUN pkill chrome
RUN chmod -R 777 ./node_modules/
RUN java --version
#RUN ls -l
RUN npm start
RUN npm test


# add app
