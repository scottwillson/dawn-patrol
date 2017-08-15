#!/bin/sh
set -e

cd /go/src/rocketsurgeryllc.com/dawnpatrol/api && go install main/api.go && rm -rf /tmp/*
/go/bin/api
