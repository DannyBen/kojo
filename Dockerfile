FROM dannyben/alpine-ruby:3.0.3
RUN gem install kojo --version 0.4.0
WORKDIR /app
ENTRYPOINT ["kojo"]
