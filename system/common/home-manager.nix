
{ flake-inputs, user, system, pkgs-stable, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = flake-inputs // { inherit user system pkgs-stable; };
    users.${user} = { ... }: {
      # home.enableNixpkgsReleaseCheck = false;
      home.stateVersion = "21.11";
      # allow home-manager to manage itself
      programs.home-manager.enable = true;
    };
  };
}
