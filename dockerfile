FROM node:lts-alpine
LABEL maintainer="zinthose"
LABEL source="https://github.com/zinthose/thingproxy-docker"

## Install Git
RUN set -x \
    && apk add --no-cache bash git openssh \
    && git --version && bash --version && ssh -V && npm -v && node -v && yarn -v

WORKDIR /usr/src/app

## Original - But a little out of date with packages
# RUN git clone https://github.com/Freeboard/thingproxy.git /usr/src/app

## Zinthose's build - Possibly unstable as it forces all packages to latest release.
RUN git clone https://github.com/zinthose/thingproxy.git /usr/src/app

RUN npm install

EXPOSE 3000
CMD [ "node", "server.js" ]