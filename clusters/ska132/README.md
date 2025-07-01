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
    * ```shell
      argocd app sync argocd/basic-components && argocd app wait argocd/basic-components
      ```
    * ```shell
      argocd app sync argocd/ingress-nginx && argocd app wait argocd/ingress-nginx
      ```
    * ```shell
      argocd app sync argocd/cert-manager && argocd app wait argocd/cert-manager
      #YOUR_ACCESS_KEY_ID=xxxxxxxxxxx
      #YOUR_ACCESS_KEY_SECRET=yyyyyyyyyyy
      kubectl -n basic-components create secret generic alidns-webhook-zverse-secrets \
        --from-literal="access-token=$YOUR_ACCESS_KEY_ID" \
        --from-literal="secret-key=$YOUR_ACCESS_KEY_SECRET"
      argocd app sync argocd/cert-manager-issuer && argocd app wait argocd/cert-manager-issuer
      ```
