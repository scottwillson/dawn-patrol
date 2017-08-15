#!/bin/sh
set -e

echo "[build.sh:building binary]"
cd /go/src/rocketsurgeryllc.com/dawnpatrol/api && go install main/api.go && rm -rf /tmp/*
echo "[build.sh:launching binary]"
/go/bin/api
