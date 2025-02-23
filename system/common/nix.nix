{ pkgs, user, ... }:
{

  nixpkgs.pkgs = pkgs;

  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      allowed-users = [ "root" ];
      trusted-users = [
        "@admin"
        user
      ];
      sandbox = if pkgs.stdenv.isDarwin then "relaxed" else true;
    };

    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
      build-max-jobs = auto
    '';
  };

  # system.checks.verifyNixPath = false;
}
