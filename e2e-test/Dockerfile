FROM ruby:2.4.1-alpine3.6

WORKDIR /ruby
COPY . .

ENV PHANTOMJS_ARCHIVE="phantomjs.tar.gz"
RUN echo '@edge http://nl.alpinelinux.org/alpine/edge/main'>> /etc/apk/repositories \
	&& apk --update add curl build-base libxml2-dev libxslt-dev

RUN curl -Lk -o $PHANTOMJS_ARCHIVE https://github.com/DarthHater/docker-phantomjs2/releases/download/2.1.1/dockerized-phantomjs.tar.gz \
	&& tar -xf $PHANTOMJS_ARCHIVE -C /tmp/ \
	&& cp -R /tmp/etc/fonts /etc/ \
	&& cp -R /tmp/lib/* /lib/ \
	&& cp -R /tmp/lib64 / \
	&& cp -R /tmp/usr/lib/* /usr/lib/ \
	&& cp -R /tmp/usr/lib/x86_64-linux-gnu /usr/ \
	&& cp -R /tmp/usr/share/* /usr/share/ \
	&& cp /tmp/usr/local/bin/phantomjs /usr/bin/ \
	&& rm -fr $PHANTOMJS_ARCHIVE  /tmp/*

RUN bundle

CMD ["rspec"]
