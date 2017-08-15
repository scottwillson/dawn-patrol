#!/bin/sh
set -e

cd /go/src/rocketsurgeryllc.com/dawnpatrol/api && go test ./... && rm -rf /tmp/*
