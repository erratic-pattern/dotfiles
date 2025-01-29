# add local packages to nixpkgs
inputs: self: super: rec {
  localPackages = super.callPackage ../../packages inputs;
  vimPlugins = super.vimPlugins.extend (self: super: localPackages.vimPlugins); 
}
