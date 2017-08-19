#!/bin/sh
set -e

cd /go/src/rocketsurgeryllc.com/dawnpatrol/api && \
go install cmd/api/api.go && \
go install cmd/import/import.go && \
rm -rf /tmp/*

/go/bin/api
