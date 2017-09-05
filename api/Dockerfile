FROM golang:1.9 as builder

WORKDIR /go/src/rocketsurgeryllc.com/dawnpatrol/api
COPY . /go/src/rocketsurgeryllc.com/dawnpatrol/api

RUN go get -u github.com/golang/dep/cmd/dep
RUN dep ensure

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo cmd/api/api.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates tzdata
COPY --from=builder /go/src/rocketsurgeryllc.com/dawnpatrol/api/api /usr/local/bin/api

CMD ["api"]
