FROM golang:alpine AS build
RUN apk add --no-cache git gcc musl-dev krb5-dev
WORKDIR /go/src/github.com/mongodb/mongo-tools
RUN git clone https://github.com/mongodb/mongo-tools.git .
RUN ./make build


FROM alpine:3.15 AS final
RUN apk add --no-cache openssl krb5 curl
COPY --from=build /go/src/github.com/mongodb/mongo-tools/bin/* /bin/
WORKDIR /tmp
