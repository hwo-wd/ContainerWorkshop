# will pull docker.io/library/alpine:3.14
FROM alpine:3.14
RUN apk add --no-cache htop

USER 1232:4434
RUN touch /tmp/myFile

ENTRYPOINT ["htop"]
