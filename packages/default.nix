# collection of all local packages 
args @ { stdenv, callPackage, vimUtils, neovimUtils, ... }:
let
  inherit (vimUtils) buildVimPlugin;
  inherit (neovimUtils) buildNeovimPlugin;
  systemPackages =
    if stdenv.isLinux
    then callPackage ./linux args
    else if stdenv.isDarwin
    then callPackage ./darwin args
    else { };

in
systemPackages // {
  vimPlugins = callPackage ./vim-plugins.nix (args // {
    inherit buildVimPlugin buildNeovimPlugin;
  });
}
    
