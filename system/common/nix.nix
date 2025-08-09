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
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      cores = 0;
      max-jobs = "auto";
    };

    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 14d";
    };
  };

  # system.checks.verifyNixPath = false;
}
