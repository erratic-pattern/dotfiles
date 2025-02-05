{ pkgs, ... }:
{
  home.packages = with pkgs; [
    protobuf
    postgresql
    libiconv
    go
    vault
  ];
}
