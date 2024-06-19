
{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    # MacOS dock utilities
    dockutil
  ];
}
