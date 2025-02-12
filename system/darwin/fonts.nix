{ pkgs, ... }:
{
  fonts = {
    packages = [
      pkgs.fira-code
      pkgs.monaspace
    ];
  };
}
