FROM node
MAINTAINER Scott Willson "<scott.willson@gmail.com>"

WORKDIR /web
COPY . .

RUN yarn
RUN yarn build

ENV HOST=0.0.0.0
CMD ["yarn", "start"]
