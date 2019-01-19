FROM ruby:2.5.3
ENV RAILS_ENV development
RUN apt install bash curl sqlite
EXPOSE 3000
ENTRYPOINT puma -b 0.0.0.0

