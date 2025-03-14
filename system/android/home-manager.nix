{
  flake-inputs,
  user,
  pkgs-unstable,
  pkgs-stable,
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = flake-inputs // {
      inherit user pkgs-unstable pkgs-stable;
    };
    config = {
      # home.enableNixpkgsReleaseCheck = false;
      home.stateVersion = "21.11";
      # allow home-manager to manage itself
      programs.home-manager.enable = true;
    };
  };
}
