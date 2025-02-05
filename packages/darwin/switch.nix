{
  self,
  system,
  darwin,
  writeShellApplication,
  ...
}:
writeShellApplication {
  name = "switch";
  runtimeInputs = [
    self
    darwin.packages.${system}.darwin-rebuild
  ];
  text = ''
    #!/bin/sh -e
    if [ -n "''${1-}" ]; then
        NAME="$1"
        shift
    else
        NAME="$(scutil --get LocalHostName)"
    fi
    darwin-rebuild switch --flake "${self}#$NAME" "$@"
  '';
}
