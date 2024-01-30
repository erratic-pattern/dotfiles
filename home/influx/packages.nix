{ pkgs, lib, ... } :  {
  home.packages = with pkgs; [
    rustup
    protobuf
    postgresql
    python3
    libiconv
  ];

  home.sessionVariables = {
    PYTHONPATH = "${pkgs.python3}/${pkgs.python3.sitePackages}";
  };

  # set default rust version to stable
  home.activation.rustupDefault =
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${pkgs.rustup}/bin/rustup default stable
    '';
}
