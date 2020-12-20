# base image
FROM node:latest
# Start from debian stretch-slim
FROM debian:stretch-slim

# Setup JAVA_HOME
ENV JAVA_HOME="/usr/lib/jvm/default-jvm"

# Install Oracle JDK (Java SE Development Kit) 11.0.1
RUN JAVA_VERSION=11 && \
    JAVA_UPDATE=0.1 && \
    JAVA_BUILD=13 && \
    JAVA_PATH=90cf5d8f270a4347a95050320eef3fb7 && \
    JAVA_SHA256_SUM=e7fd856bacad04b6dbf3606094b6a81fa9930d6dbb044bbd787be7ea93abc885 && \
    apt-get update && \
    apt-get -y install wget && \
    cd "/tmp" && \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}.${JAVA_UPDATE}+${JAVA_BUILD}/${JAVA_PATH}/jdk-${JAVA_VERSION}.${JAVA_UPDATE}_linux-x64_bin.tar.gz" && \
    echo "${JAVA_SHA256_SUM}" "jdk-${JAVA_VERSION}.${JAVA_UPDATE}_linux-x64_bin.tar.gz" | sha256sum -c - && \
    tar -xzf "jdk-${JAVA_VERSION}.${JAVA_UPDATE}_linux-x64_bin.tar.gz" && \
    mkdir -p "/usr/lib/jvm" && \
    mv "/tmp/jdk-${JAVA_VERSION}.${JAVA_UPDATE}" "/usr/lib/jvm/java-${JAVA_VERSION}-oracle" && \
    ln -s "java-${JAVA_VERSION}-oracle" "$JAVA_HOME" && \
    ln -s "$JAVA_HOME/bin/"* "/usr/bin/" && \
    rm -rf "$JAVA_HOME/README.html" \
           "$JAVA_HOME/bin/jjs" \
           "$JAVA_HOME/bin/keytool" \
           "$JAVA_HOME/bin/pack200" \
           "$JAVA_HOME/bin/rmid" \
           "$JAVA_HOME/bin/rmiregistry" \
           "$JAVA_HOME/bin/unpack200" \   
           "$JAVA_HOME/conf/security/policy/README.txt" \    
           "$JAVA_HOME/lib/jfr" \
           "$JAVA_HOME/lib/src.zip" && \
    apt-get -y autoremove wget && \
    apt-get -y clean && \
    rm -rf "/tmp/"* \
           "/var/cache/apt" \
           "/usr/share/man" \
           "/usr/share/doc" \
           "/usr/share/doc-base" \
           "/usr/share/info/*"
           
#Prints installed java version, just for checking
RUN java --version

#install wget
RUN apt-get install wget

#install chrome for protractor tests
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -yq google-chrome-stable

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
