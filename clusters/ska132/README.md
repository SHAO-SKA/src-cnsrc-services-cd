# ska132

## argocd

1. install by helm
    * ```shell
      bash clusters/ska132/applications/argocd/install.sh
      ```
2. login
    * ```shell
      bash clusters/ska132/applications/argocd.login.sh
      ```

## applications

1. apply main application to k8s cluster
    * ```shell
      kubectl -n argocd apply -f clusters/ska132/applications.app.yaml
      ```
2. sync and wait for the main application to be ready
    * ```shell
      argocd app sync argocd/root-app --prune && argocd app wait argocd/root-app
      ```
    * sub modules will be introduced by the root-app
3. sync and wait for `basic-components` to be ready
    * sub module entrance
        + ```shell
          argocd app sync argocd/basic-components && argocd app wait argocd/basic-components
          ```
    * without storage class
        + ```shell
          argocd app sync argocd/ingress-nginx && argocd app wait argocd/ingress-nginx
          ```
        + ```shell
          argocd app sync argocd/cert-manager && argocd app wait argocd/cert-manager
          argocd app sync argocd/alidns-webhook-zverse && argocd app wait argocd/alidns-webhook-zverse
          #YOUR_ACCESS_KEY_ID=xxxxxxxxxxx
          #YOUR_ACCESS_KEY_SECRET=yyyyyyyyyyy
          kubectl -n basic-components create secret generic alidns-webhook-zverse-secrets \
            --from-literal="access-token=$YOUR_ACCESS_KEY_ID" \
            --from-literal="secret-key=$YOUR_ACCESS_KEY_SECRET"
          argocd app sync argocd/cert-manager-issuer && argocd app wait argocd/cert-manager-issuer
          ```
        + ```shell
          kubectl get namespace business-workflows > /dev/null 2>&1 || kubectl create namespace business-workflows
          argocd app sync argocd/argo-workflows && argocd app wait argocd/argo-workflows
          ```
    * with storage class
        + [make storage ready](#storage-dependency)
        + ```shell
          argocd app sync argocd/chart-museum && argocd app wait argocd/chart-museum
          ```
        + ```shell
          argocd app sync argocd/container-image-mirror && argocd app wait argocd/container-image-mirror
          ```
        + ```shell
          argocd app sync argocd/container-registry && argocd app wait argocd/container-registry
          ```
4. sync and wait for `storage` to be ready
    * sub module entrance
        + ```shell
          argocd app sync argocd/storage && argocd app wait argocd/storage
          ```
    * sub module sync
        + ```shell
          argocd app sync argocd/nfs-provisioner && argocd app wait argocd/nfs-provisioner
          ```
5. sync and wait for `monitor` to be ready
    * sub module entrance
        + ```shell
          argocd app sync argocd/monitor && argocd app wait argocd/monitor
          ```
    * sub module sync
        + ```shell
          kubectl get namespace monitor > /dev/null 2>&1 || kubectl create namespace monitor
          kubectl -n monitor create secret generic kube-prometheus-grafana-credentials \
            --from-literal="admin-user=admin" \
            --from-literal="admin-password=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 16)"
          argocd app sync argocd/kube-prometheus-stack && argocd app wait argocd/kube-prometheus-stack
          ```
        + ```shell
          argocd app sync argocd/prometheus-push-gateway && argocd app wait argocd/prometheus-push-gateway
          ```
