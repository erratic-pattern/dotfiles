{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    dockutil
    skhd
  ];
  home.activation.installSkhd = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.skhd}/bin/skhd --install-service && \
    ${pkgs.skhd}/bin/skhd --start-service
  '';
   
  xdg.configFile."skhd/skhdrc" = {
    source = ./config/skhdrc;
  };

}
