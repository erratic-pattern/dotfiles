{ pkgs, ... }:
{
  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
      build-max-jobs = auto
    '';
  };
}
