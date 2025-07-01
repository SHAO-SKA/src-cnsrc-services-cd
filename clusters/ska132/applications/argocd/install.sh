#! /bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

helm upgrade --install argo-cd argo-cd \
        --namespace argocd --create-namespace \
        --repo https://argoproj.github.io/argo-helm \
        --version 8.1.2 \
        --values $SCRIPT_DIR/values.yaml \
        --atomic
