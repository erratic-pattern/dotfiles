{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protobuf
    postgresql
    libiconv
    go
    vault
    grafana-loki
    kubectl
    kubectx
    kubecm
    kubelogin-oidc
    (google-cloud-sdk.withExtraComponents (
      with pkgs.google-cloud-sdk.components;
      [
        gke-gcloud-auth-plugin
      ]
    ))
  ];
}
