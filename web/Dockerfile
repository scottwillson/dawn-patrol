FROM node as builder
MAINTAINER Scott Willson "<scott.willson@gmail.com>"

WORKDIR /web
COPY package.json .

RUN yarn install

COPY . .

RUN yarn build

FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /web/build /web/build
