{ pkgs, user, ... }:
let
  inherit (pkgs) skhd;
in
{
  services.skhd = {
    enable = true;
    package = skhd;
  };

  system.activationScripts.postActivation.text = ''
    echo 'restarting skhd...'
    su - ${user} -c '${skhd}/bin/skhd -r'
  '';
}
