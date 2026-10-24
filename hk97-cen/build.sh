#!/bin/sh
# Builds ./hongkong97 from the sources and assets (Go 1.22+ required).
set -e
go mod tidy
go generate ./cmd/hk97
go build -trimpath -ldflags "-s -w" -o hongkong97 ./cmd/hk97
echo "Built ./hongkong97"
