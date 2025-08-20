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
    # use sudo askpass in non-interactive session
    if ! [ -t 0 ] && ! [ -t 1 ] && [ -n "$SUDO_ASKPASS" ]; then
        SUDO_OPTS='-A'
    else
        SUDO_OPTS='''
    fi

    # find configuration name
    if [ -n "''${1-}" ]; then
        NAME="$1"
        shift
    else
        HOSTNAME="$(scutil --get LocalHostName)"
        echo "Finding configuration using local hostname: $HOSTNAME"
        NAME="$(\
          nix eval --raw ${self}#darwinConfigurations \
          --apply "configs: with builtins; head (filter (name: configs.\''${name}.config.networking.hostName == \"$HOSTNAME\") (attrNames configs))")"
        echo "Found configuration: $NAME"
    fi
    sudo $SUDO_OPTS darwin-rebuild switch --flake "${self}#$NAME" "$@"
  '';
}
