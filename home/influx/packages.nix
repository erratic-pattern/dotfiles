{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    rustup
    protobuf
    postgresql
    python3
    libiconv
    go
  ];

  home.sessionVariables = {
    PYTHONPATH = "${pkgs.python3}/${pkgs.python3.sitePackages}";
  };

  programs.zsh = {
    initExtra = ''
      export PATH="$PATH:$HOME/go/bin"
    '';
  };

  # set default rust version to stable
  home.activation.rustupDefault =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.rustup}/bin/rustup default stable
    '';
}

