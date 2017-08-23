FROM golang:1.8

WORKDIR /go/src/rocketsurgeryllc.com/dawnpatrol/api
COPY . .

ENV GOBIN=$GOPATH/bin

RUN go get github.com/cespare/reflex
RUN go get github.com/stretchr/testify/assert
RUN go get ./...
