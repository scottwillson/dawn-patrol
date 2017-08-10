FROM node
MAINTAINER Scott Willson "<scott.willson@gmail.com>"

WORKDIR /web
COPY . .
RUN apt-get update
RUN apt-get install -y nginx
RUN cp nginx.conf /etc/nginx/sites-enabled/default
RUN yarn
RUN yarn build
RUN chown -R www-data:www-data /web/build

CMD ["nginx", "-g", "daemon off;"]
