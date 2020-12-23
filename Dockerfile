FROM node:lts-alpine3.10
#lts - 12.16.1
LABEL authors="Ganesh Kudale"
#Linux setup
RUN apk add && apk update --no-cache\
  && apk add --update alpine-sdk \
  && apk del alpine \
  && rm -rf /tmp/* /var/cache/apk/* *.tar.gz ~/.npm \
  && npm cache verify \
  && sed -i -e "s/bin\/ash/bin\/sh/" /etc/passwd \
  && apk add --no-cache curl \
  && apk add --no-cache mlocate \
  && apk add --no-cache chromium \
  && apk add --no-cache openjdk8 \
  && apk add --no-cache chromium-chromedriver
  ENV CHROME_BIN=/usr/bin/chromium-browser
  ENV CHROME_DRIVER=/usr/bin/chromedriver
  ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
  ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/bin
#Angular
ARG USER_HOME_DIR="/tmp"
ARG APP_DIR="/app"
ARG USER_ID=1000
ENV NPM_CONFIG_LOGLEVEL=warn NG_CLI_ANALYTICS=false
ENV HOME "$USER_HOME_DIR"
WORKDIR $APP_DIR
EXPOSE 4200
RUN set -xe \
    && mkdir -p $USER_HOME_DIR \
    && chown $USER_ID $USER_HOME_DIR \
    && chmod a+rw $USER_HOME_DIR \
    && mkdir -p $APP_DIR \
    && chown $USER_ID $APP_DIR \
    && chown -R node /usr/local/lib /usr/local/include /usr/local/share /usr/local/bin \
    && rm /usr/local/lib/sonarscanner/jre -rf \
    && export CHROME_VERSION=$("$CHROME_BIN" -version | awk '{ print $2 }') \
    && (cd "$USER_HOME_DIR";su node -c "npm install -g protractor;webdriver-manager update --versions.chrome=$CHROME_VERSION;npm cache clean --force")

USER $USER_ID
VOLUME /reports
