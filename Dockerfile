FROM ruby:3.4-alpine3.23

RUN mkdir /app && mkdir /config
ENV HOME=/config

COPY startup.sh /app
RUN chmod +x /app/startup.sh

RUN apk update && \
    apk add git mktorrent build-base && \
    git clone https://gitlab.com/ItchyVision/redcurry.git

RUN mv redcurry*/** /app && chmod +x /app/redcurry.rb
ENV PATH="$PATH:/app"

WORKDIR /app
RUN bundle install
ENTRYPOINT ["/app/startup.sh"]
