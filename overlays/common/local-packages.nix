# add local packages to nixpkgs
inputs: final: prev: rec {
  localPackages = prev.callPackage ../../packages (inputs // { inherit final prev; });
  vimPlugins = prev.vimPlugins.extend (_: _: localPackages.vimPlugins);
}
