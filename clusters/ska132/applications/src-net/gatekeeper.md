# gatekeeper

## helm chart package

1. clone code
    * ```shell
      git clone https://gitlab.com/AaronYang2333/ska-src-dm-da-service-gatekeeper.git
      ```
2. render templates by make
    * ```shell
      podman run --rm \
        -v $(pwd)/ska-src-dm-da-service-gatekeeper:/code \
        --workdir /code \
        -it m.daocloud.io/docker.io/library/golang:latest \
        bash -c 'curl -L -o /tmp/helm-v3.18.3-linux-amd64.tar.gz https://get.helm.sh/helm-v3.18.3-linux-amd64.tar.gz && tar zxvf /tmp/helm-v3.18.3-linux-amd64.tar.gz -C /tmp/ && mv /tmp/linux-amd64/helm /usr/local/bin/ && export GOPROXY=https://goproxy.cn,direct && go install github.com/mikefarah/yq/v3@latest && make build-gatekeeper-helm-templates && helm dependency update etc/helm'
      ```
3. package helm chart
    * ```shell
      mkdir -p /tmp/helm-chart
      podman run --rm \
        -v $(pwd)/ska-src-dm-da-service-gatekeeper:/code \
        -v /tmp/helm-chart:/code/.build/chart \
        -it m.daocloud.io/docker.io/alpine/k8s:1.29.4 \
        helm package --dependency-update \
          --destination /code/.build/chart \
          /code/etc/helm
      ```
4. push helm chart package
    * ```shell
      podman run --rm \
        -v /tmp/helm-chart:/code/.build/chart \
        -it m.daocloud.io/docker.io/alpine/k8s:1.29.4 \
        helm cm-push \
          /code/.build/chart/ska-src-dm-da-service-gatekeeper-0.2.4.tgz \
          https://chart-museum.internal.ska.zverse.space:32443 \
          --context-path /
      ```

## how to delete a existing chart package and update

```shell
curl -X DELETE https://chart-museum.internal.ska.zverse.space:32443/api/charts/ska-src-dm-da-service-gatekeeper/0.2.4
```
```shell
kubectl -n argocd delete pod argo-cd-argocd-repo-server-...-...
kubectl -n argocd delete pod argo-cd-argocd-redis-...-...
```