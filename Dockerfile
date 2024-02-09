FROM dannyben/alpine-ruby:3.2.2

RUN gem install kojo --version 0.4.4

WORKDIR /app

VOLUME /app

ENTRYPOINT ["kojo"]
