FROM node:14.0.0 as builder
MAINTAINER Scott Willson "<scott.willson@gmail.com>"

WORKDIR /web
COPY package.json .

RUN npm install

COPY . .

RUN npm run build

FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /web/build /web/build
