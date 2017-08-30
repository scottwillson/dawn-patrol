FROM node
MAINTAINER Scott Willson "<scott.willson@gmail.com>"

WORKDIR /web
COPY package.json .

RUN yarn install

COPY . .
