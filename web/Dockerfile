FROM mhart/alpine-node
MAINTAINER Scott Willson "<scott.willson@gmail.com>"

WORKDIR web
COPY . .
RUN apk add --no-cache nginx
RUN cp nginx.conf /etc/nginx/conf.d/default.conf
RUN yarn
RUN yarn build
RUN mkdir -p /usr/share/nginx/html
RUN chown -R nginx:nginx /usr/share/nginx/html
RUN cp -r build /usr/share/nginx/html
RUN nginx -t

CMD ["nginx"]
