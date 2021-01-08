FROM node:14-alpine

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL author="Lukas Bartak"
LABEL maintainer="bart@bartweb.cz"
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.license="MIT" \
      org.label-schema.name="node-alpine" \
      org.label-schema.description="Lightweight Docker image based on NodeJS 14 Alpine with Yarn, ssh, git and bash." \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

# Commands
RUN \
  apk update && \
  apk upgrade && \
  apk add --no-cache git bash openssh-client rsync curl && \
  node -v && yarn -v && npm -v && git --version && bash --version && ssh -V && rsync --version && curl -V
