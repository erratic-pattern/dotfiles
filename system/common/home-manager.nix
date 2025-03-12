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
    backupFileExtension = "backup";
    extraSpecialArgs = flake-inputs // {
      inherit user pkgs-unstable pkgs-stable;
    };
    users.${user} =
      { ... }:
      {
        # home.enableNixpkgsReleaseCheck = false;
        home.stateVersion = "21.11";
        # allow home-manager to manage itself
        programs.home-manager.enable = true;
      };
  };
}
