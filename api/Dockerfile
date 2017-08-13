FROM golang:1.8

WORKDIR /go/src/rocketsurgeryllc.com/dawnpatrol/api
COPY . .

RUN go get ./...
RUN go build ./...

CMD ["go", "test", "./..."]
