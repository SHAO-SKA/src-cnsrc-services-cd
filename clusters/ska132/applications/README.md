# applications

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
      kubectl apply -f clusters/ska132/applications.app.yaml
      ```
2. sync and wait for the main application to be ready
    * ```shell
      argocd app sync argocd/applications && argocd app wait argocd/applications
      ```
    * sub modules will be introduced by the main application
3. sync and wait for `basic-components` to be ready
    * ```shell
      argocd app sync argocd/basic-components && argocd app wait argocd/basic-components
      ```
