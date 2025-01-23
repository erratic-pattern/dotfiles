# extend the nixpkgs lib with custom local lib.
inputs: self: super: {
  lib = super.lib.extend
    (self: super: {
      local = import ../lib.nix inputs;
    });
}
