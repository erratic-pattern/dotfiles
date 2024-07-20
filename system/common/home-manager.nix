
{ inputs, user, system, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = inputs // { inherit user system; };
    users.${user} = { ... }: {
      home.enableNixpkgsReleaseCheck = false;
      home.stateVersion = "21.11";
      # allow home-manager to manage itself
      programs.home-manager.enable = true;
    };
  };
}
