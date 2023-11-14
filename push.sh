#!/bin/bash

docker_build_push() {
    cd $1
    docker build --platform $3 -t yumekiti/$2 .
    docker push yumekiti/$2
    cd ..
}

# cms
docker_build_push "cms" "anitection-cms" "linux/arm64/v8"

# bff
docker_build_push "bff" "anitection-bff" "linux/arm64/v8"