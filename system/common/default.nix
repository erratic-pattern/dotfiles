{ pkgs, inputs, user, system, ... }: {

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
    '';
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  system.checks.verifyNixPath = false;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = inputs // {inherit user system; };
    users.${user} = { ... }: {
      home.enableNixpkgsReleaseCheck = false;
      home.stateVersion = "21.11";
      # allow home-manager to manage itself
      programs.home-manager.enable = true;
    };
  };
}
