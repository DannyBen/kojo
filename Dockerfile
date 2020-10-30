FROM dannyben/alpine-ruby:ruby2.6.5
RUN gem install kojo --version 0.3.8
WORKDIR /app
ENTRYPOINT ["kojo"]
