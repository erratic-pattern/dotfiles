# extend the nixpkgs lib with custom local lib.
inputs: final: prev: {
  lib = prev.lib.extend (
    final: prev: {
      local = import ../lib.nix inputs;
    }
  );
}
