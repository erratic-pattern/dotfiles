{
  pkgs,
  user,
  flake-inputs,
  ...
}:
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

    # Add custom flake registry entries
    registry = {
      # Local packages from this flake
      local.flake = flake-inputs.self;
      # nixpkg versions from flake inputs
      nixpkgs.flake = flake-inputs.nixpkgs;
      nixpkgs-stable.flake = flake-inputs.nixpkgs-stable;
      nixpkgs-unstable.flake = flake-inputs.nixpkgs-unstable;
    };

    nixPath = pkgs.lib.mkAfter [
      # Make all versions of nixpkgs from this flake available as channels
      "nixpkgs=/etc/nixpkgs/channels/nixpkgs"
      "nixpkgs-stable=/etc/nixpkgs/channels/nixpkgs-stable"
      "nixpkgs-unstable=/etc/nixpkgs/channels/nixpkgs-unstable"
      # Make local packages available to legacy nix-shell commands via overlays
      "nixpkgs-overlays=/etc/nixpkgs/channels/nixpkgs-overlays"
    ];
  };

  # Create channel symlinks from flake inputs and our local package overlay
  environment.etc =
    let
      localPackages = pkgs.writeText "local-packages.nix" ''
        final: prev:
          import ${flake-inputs.self}/overlays/common/local-packages.nix {} final prev
      '';
      overlays =
        pkgs.runCommand "overlays" { }
          "mkdir -p $out && cp ${localPackages} $out/local-packages.nix";
    in
    {
      "nixpkgs/channels/nixpkgs".source = flake-inputs.nixpkgs;
      "nixpkgs/channels/nixpkgs-stable".source = flake-inputs.nixpkgs-stable;
      "nixpkgs/channels/nixpkgs-unstable".source = flake-inputs.nixpkgs-unstable;
      "nixpkgs/channels/nixpkgs-overlays".source = overlays;
    };

  # system.checks.verifyNixPath = false;
}
