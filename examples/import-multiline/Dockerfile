FROM alpine

@import base

ENV ENVIRONMENT %{env}

@import packages ( packages: "curl wget" )

EXPOSE 3000

@import command (
  region: "us",
  host: "example.com"
)

