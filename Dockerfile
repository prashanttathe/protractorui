# chromium > 76 is required. For now, this is only available in the 'edge' build
FROM alpine:edge

USER root

RUN apk add openjdk11 
RUN java --version

#install npm
#RUN apk update && apk upgrade -y && \
 #   apk add -y nodejs \
  #  npm                       # note this one
RUN apk add  --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.7/main/ nodejs=8.9.3-r1
    
# Install chromium, some dependnecies, node and dumb-init
RUN apk add --no-cache \
      chromium nss freetype freetype-dev harfbuzz ca-certificates ttf-freefont \
      nodejs npm \
      dumb-init

# Add user so we don't need --no-sandbox.
RUN addgroup -S chromium &&\
    adduser -S -g chromium chromium &&\
    mkdir /app &&\
    chown -R chromium:chromium /app

# Run everything after as non-privileged user.
USER chromium

# Set CHROME_BIN to avoid tweaking config files (e.g. karma.conf.js)
ENV CHROME_BIN=/usr/bin/chromium-browser

WORKDIR /app

# dumb-init avoids having zombie Chrome processes
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH
ENV REST_HOST=$REST_HOST
ENV REST_PORT=$REST_PORT

User root
# install and cache app dependencies
#RUN pwd
#RUN ls
COPY package.json /app/package.json
#Global npm dependencies
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
#optionally if you want to run npm global bin without specifying path
ENV PATH=$PATH:/home/node/.npm-global/bin
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
WORKDIR ./Reports
RUN ls -lh
#RUN cat 2020-12-21.html
#RUN echo "Protractor report" | mail -s "Protractor Report Here" tathe.prashant@gmail.com -A 2020-12-20.html
RUN pwd

# add app
