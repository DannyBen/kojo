FROM dannyben/alpine-ruby:3.1.3
RUN gem install kojo --version 0.4.2
WORKDIR /app
ENTRYPOINT ["kojo"]
