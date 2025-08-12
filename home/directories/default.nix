{ lib, ... }:
{
  home.activation.directories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p "$HOME/Code"
    run mkdir -p "$HOME/Notes"
  '';
}
