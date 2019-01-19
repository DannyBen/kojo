FROM ruby:2.5.3
ENV RAILS_ENV production
RUN apt install bash curl postgres
EXPOSE 80
ENTRYPOINT prod.sh

