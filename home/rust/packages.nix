{ pkgs, lib, ... }:
let
  inherit (lib) listToAttrs;
  inherit (builtins) baseNameOf unsafeDiscardStringContext;
in
{
  home.packages = with pkgs; [
    rustup
  ];

  # Install cargo utilities into ~/.cargo/bin
  home.file = listToAttrs
    (
      map
        (p: {
          name = ".cargo/bin/${baseNameOf (unsafeDiscardStringContext p)}";
          value = { source = p; };
        })
        (with pkgs; [
          "${cargo-binstall}/bin/cargo-binstall"
          "${cargo-deny}/bin/cargo-deny"
          "${cargo-hakari}/bin/cargo-hakari"
          "${cargo-insta}/bin/cargo-insta"
          "${cargo-nextest}/bin/cargo-nextest"
          "${cargo-sweep}/bin/cargo-sweep"
          "${cargo-udeps}/bin/cargo-udeps"
          "${critcmp}/bin/critcmp"
          "${sqlx-cli}/bin/cargo-sqlx"
          "${sqlx-cli}/bin/sqlx"
          "${taplo}/bin/taplo"
        ]));

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  # set default rust version to stable
  home.activation.rustupDefault =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.rustup}/bin/rustup default stable
    '';
}

