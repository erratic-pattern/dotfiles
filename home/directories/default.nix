{ lib, ... }:
{
  home.activation.directories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/Code"
    mkdir -p "$HOME/Notes"
  '';
}
