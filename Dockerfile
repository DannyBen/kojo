FROM dannyben/alpine-ruby:ruby2.6.5
RUN gem install kojo
WORKDIR /app
ENTRYPOINT ["kojo"]
