{
  user,
  specialArgs,
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = specialArgs;
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
