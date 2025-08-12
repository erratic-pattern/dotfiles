# collection of all local packages
args@{
  stdenv,
  callPackage,
  vimUtils,
  neovimUtils,
  rustPlatform,
  ...
}:
let
  inherit (vimUtils) buildVimPlugin;
  inherit (neovimUtils) buildNeovimPlugin;
  inherit (rustPlatform) buildRustPackage;
  systemPackages =
    if stdenv.isLinux then
      callPackage ./linux args
    else if stdenv.isDarwin then
      callPackage ./darwin args
    else
      { };

in
systemPackages
// {
  claude-monitor = callPackage ./claude-monitor.nix args;
  influxdb3-core = callPackage ./influxdb3-core.nix args;
  vimPlugins = callPackage ./vim-plugins.nix (
    args
    // {
      inherit buildVimPlugin buildNeovimPlugin;
    }
  );
}
