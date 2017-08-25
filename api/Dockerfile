FROM golang:1.9

WORKDIR /go/src/rocketsurgeryllc.com/dawnpatrol/api
COPY . .

ENV GOBIN=$GOPATH/bin

RUN go get github.com/cespare/reflex
RUN go get -u github.com/golang/dep/cmd/dep
RUN dep ensure
