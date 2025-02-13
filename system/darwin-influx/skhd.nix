{ ... }:
{
  imports = [
    ../darwin/skhd.nix
  ];
  services.skhd.skhdConfig = ''
    hyper - z : open -a '/Applications/zoom.us.app/'
  '';
}
