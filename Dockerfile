FROM ubuntu:20.04

ENV GITHUB_TOKEN
ENV DRAFT_NAME

RUN apt-get update && \
    apt-get install -y -qq \
    jq \
    ruby-kramdown-rfc2629 \
    xml2rfc

COPY docker-entrypoint.sh Makefile .
ENTRYPOINT ["./docker-entrypoint.sh"]
