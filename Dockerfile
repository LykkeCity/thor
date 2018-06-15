FROM golang:1.10.2-alpine as builder

RUN apk add --no-cache curl git make gcc libc-dev

RUN cd / && \
    git clone https://github.com/LykkeCity/thor.git && \
    cd thor && \
    git submodule init && \
    git submodule update && \
    make

FROM alpine:latest

COPY --from=builder /thor/bin/thor /usr/local/bin/

EXPOSE 8669 11235 11235/udp

ENTRYPOINT ["thor"]