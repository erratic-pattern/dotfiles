{ pkgs, ... }:
let
  inherit (pkgs) skhd;
in
{
  environment.systemPackages =
    [
      skhd
    ];
  services.skhd = {
    enable = true;
    package = skhd;
  };

  system.activationScripts.postUserActivation.text = ''
    ${skhd}/bin/skhd -r
  '';
}
