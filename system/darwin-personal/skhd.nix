{ pkgs, ... }:
{
  imports = [
    ../darwin/skhd.nix
  ];
  services.skhd = {
    skhdConfig = ''
      hyper - d : open '${pkgs.discord}/Applications/Discord.app/'
    '';
  };
}
