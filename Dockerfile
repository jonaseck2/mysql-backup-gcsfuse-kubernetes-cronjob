FROM golang:alpine3.7
RUN apk add --no-cache git
ENV GOPATH /go
RUN go get -u github.com/googlecloudplatform/gcsfuse

FROM alpine:3.7
RUN apk add --no-cache ca-certificates fuse mysql-client && rm -rf /tmp/*
COPY --from=0 /go/bin/gcsfuse /usr/local/bin