FROM node:lts-alpine as build

## Install Git
RUN set -x \
    && apk add --no-cache bash git openssh

WORKDIR /usr/src/app

## Original - But a little out of date with packages
# RUN git clone ${src_thingproxy:-https://github.com/Freeboard/thingproxy.git} /usr/src/app

## Zinthose's build - Possibly unstable as it forces all packages to latest release.
RUN git clone ${src_thingproxy:-https://github.com/Pierre-Lannoy/thingproxy.git} /usr/src/app

## Install
RUN npm install

## Clean Up
RUN set -x \ 
    && rm -rf .git \
    && rm -f README.md

## Build new image from "compiled" install to reduce deployed image size
FROM node:lts-alpine
LABEL maintainer="zinthose"
LABEL source="https://github.com/Pierre-Lannoy/thingproxy-docker"
WORKDIR /app
COPY --from=build /usr/src/app /app
EXPOSE 3000
CMD [ "node", "server.js" ]
