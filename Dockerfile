FROM ubuntu:20.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
    curl \
    jq \
    git \
    ruby-kramdown-rfc2629 \
    xml2rfc

COPY docker-entrypoint.sh Makefile ./
ENTRYPOINT ["./docker-entrypoint.sh"]
