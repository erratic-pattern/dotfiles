{ lib, ... }:
{
  home.activation.directories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/Notes
    mkdir -p ~/Code
  '';
}
