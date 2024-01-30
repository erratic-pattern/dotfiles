{ pkgs, ... }: {

  nixpkgs = {
    config = {
      allowUnfree = true;
      # cudaSupport = true;
      # cudaCapabilities = ["8.0"];
      allowBroken = true;
      # allowInsecure = false;
      allowUnsupportedSystem = true;
    };
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # Setup user, packages, programs
  nix = {
    package = pkgs.nixUnstable;
    settings = {
      allowed-users = ["root"];
      trusted-users = ["@admin" "adam"];
    };

    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };


  system.checks.verifyNixPath = false;
}
