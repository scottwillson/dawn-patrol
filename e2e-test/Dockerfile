FROM scottwillson/dawn-patrol-e2e-base

WORKDIR /ruby
COPY . .
USER chrome
ENV DISPLAY=:99
CMD ["rspec"]
