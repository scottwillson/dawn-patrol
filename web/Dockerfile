FROM node
MAINTAINER Scott Willson "<scott.willson@gmail.com>"

WORKDIR /web
COPY . .

RUN yarn

ENV HOST=0.0.0.0
CMD ["yarn", "start"]
