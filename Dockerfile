FROM ruby:2.6.2-alpine3.9
RUN gem install pact_broker-client -v 1.18.0
ENTRYPOINT ["pact-broker"]
