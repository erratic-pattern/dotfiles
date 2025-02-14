{
  user,
  homebrew-core,
  homebrew-cask,
  homebrew-bundle,
  nix-homebrew,
  ...
}:
let
  brewShellEnv = # sh
    ''eval "$(/opt/homebrew/bin/brew shellenv)"'';
in
{
  imports = [
    nix-homebrew.darwinModules.nix-homebrew
  ];
  nix-homebrew = {
    enable = true;
    user = user;
    taps = {
      "homebrew/core" = homebrew-core;
      "homebrew/cask" = homebrew-cask;
      "homebrew/bundle" = homebrew-bundle;
    };
    mutableTaps = true;
    autoMigrate = true;
  };

  environment.shellInit = brewShellEnv;

}
