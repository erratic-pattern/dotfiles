# collection of all local packages 
args @ { callPackage, vimUtils, neovimUtils, ... }:
let
  inherit (vimUtils) buildVimPlugin;
  inherit (neovimUtils) buildNeovimPlugin;
in
{
  vimPlugins = callPackage ./vim-plugins.nix (args // {
    inherit buildVimPlugin buildNeovimPlugin;
  });
}
    
