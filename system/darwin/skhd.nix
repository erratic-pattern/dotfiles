{ pkgs, ... }:
let
  inherit (pkgs) skhd;
in
{
  services.skhd = {
    enable = true;
    package = skhd;
  };

  system.activationScripts.postUserActivation.text = ''
    echo 'restarting skhd...'
    ${skhd}/bin/skhd -r
  '';
}
