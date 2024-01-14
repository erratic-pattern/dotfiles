{ pkgs, lib, ... } :  {
  home.packages = with pkgs; [
    #IOx dependencies
    rustup
    protobuf
    postgresql
  ];

  # set default rust version to stable
  home.activation.rustupDefault =
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${pkgs.rustup}/bin/rustup default stable
    '';
}
