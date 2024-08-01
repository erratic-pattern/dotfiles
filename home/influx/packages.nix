{ pkgs, lib, config, ... }: {
  home.packages = with pkgs; [
    rustup
    protobuf
    postgresql
    libiconv
    go
    cmake
    ninja
    vault
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

