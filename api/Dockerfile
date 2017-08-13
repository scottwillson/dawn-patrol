FROM golang:1.8

WORKDIR /go/src/rocketsurgeryllc.com/dawnpatrol/api
COPY . .

RUN go get github.com/codegangsta/gin
RUN go get ./...
RUN GOBIN=$GOPATH/bin go-wrapper install main/api.go

CMD ["api"]
