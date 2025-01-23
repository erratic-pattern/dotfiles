{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    rustup
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  # set default rust version to stable
  home.activation.rustupDefault =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.rustup}/bin/rustup default stable
    '';
}

