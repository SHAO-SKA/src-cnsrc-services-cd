#!/bin/bash

set -euo pipefail
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

podman run \
    --name haproxy \
    --restart always \
    -p 443:32443 \
    -p 861:31861 \
    -p 5201:31521 \
    -v $SCRIPT_DIR/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:ro \
    -d m.daocloud.io/docker.io/library/haproxy:2.9.11
