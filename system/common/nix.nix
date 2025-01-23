{ pkgs, user, ... }: {

  nixpkgs.pkgs = pkgs;

  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      allowed-users = [ "root" ];
      trusted-users = [ "@admin" user ];
    };

    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
      build-max-jobs = auto
    '';
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  system.checks.verifyNixPath = false;
}
