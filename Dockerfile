FROM python:3.9.4-alpine

WORKDIR /opt/okta-awscli

COPY . .

# hadolint ignore=DL3018, DL4006
RUN  addgroup -S authme -g 1000 && adduser -S authme -u 1000 -G authme &&\
    apk add --no-cache --virtual .build-deps \
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev &&\
    pip install awscli &&\
    python setup.py install &&\
    apk del --purge .build-deps

USER authme
ENTRYPOINT ["/usr/local/bin/okta-awscli"]
