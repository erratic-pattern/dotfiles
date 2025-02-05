{
  self,
  nix-on-droid,
  system,
  writeShellApplication,
  ...
}:
writeShellApplication {
  name = "switch";
  runtimeInputs = [ nix-on-droid.packages.${system}.nix-on-droid ];
  text = ''
    #!/bin/sh -e

    case "$(uname -r)" in
        *android*)
            PLATFORM='android'
            ;;
        *)
            echo "Unsupported Linux platform. Aborting."
            exit 1
            ;;
    esac

    if [ -n "''${1-}" ]; then
        NAME="$1"
        shift
    elif [ "$PLATFORM" = 'android' ]; then
        NAME="default"
    fi

    if [ "$PLATFORM" = 'android' ]; then
        nix-on-droid switch --flake "${self}#$NAME" "$@"
    fi
  '';
}
