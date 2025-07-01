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
