from docker:24

run apk upgrade --no-cache
run apk add --update python3 py-pip python3-dev build-base libffi-dev \
  && pip install --upgrade pip --break-system-packages \
  && pip install awscli aws-sam-cli --break-system-packages


# https://github.com/docker-library/docker/pull/166
#   dockerd-entrypoint.sh uses DOCKER_TLS_CERTDIR for auto-generating TLS certificates
#   docker-entrypoint.sh uses DOCKER_TLS_CERTDIR for auto-setting DOCKER_TLS_VERIFY and DOCKER_CERT_PATH
# (For this to work, at least the "client" subdirectory of this path needs to be shared between the client and server containers via a volume, "docker cp", or other means of data sharing.)
ENV DOCKER_TLS_CERTDIR=/certs

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
