{
  config,
  lib,
  user,
  ...
}:
{

  # https://github.com/LnL7/nix-darwin/issues/139#issuecomment-1230728610
  # Nix-darwin does not link installed applications to the user environment. This means apps will not show up
  # in spotlight, and when launched through the dock they come with a terminal window. This is a workaround.
  # Upstream issue: https://github.com/LnL7/nix-darwin/issues/214
  system.activationScripts.applications.text = lib.mkForce ''
    echo "setting up ~/Applications..." >&2
    applications="$HOME/Applications"
    nix_apps="$applications/Nix Apps Aliases"

    # Needs to be writable by the user so that home-manager can symlink into it
    if ! test -d "$applications"; then
        mkdir -p "$applications"
        chown "$USER:" "$applications"
        chmod u+w "$applications"
    fi

    # Delete the directory to remove old links
    rm -rf "$nix_apps"
    mkdir -p "$nix_apps"
    find ${config.system.build.applications}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
            # Spotlight does not recognize symlinks, it will ignore directory we link to the applications folder.
            # It does understand MacOS aliases though, a unique filesystem feature. Sadly they cannot be created
            # from bash (as far as I know), so we use the oh-so-great Apple Script instead.
            /usr/bin/osascript -e "
                set fileToAlias to POSIX file \"$src\" 
                set applicationsFolder to POSIX file \"$nix_apps\"
                tell application \"Finder\"
                    make alias file to fileToAlias at applicationsFolder
                    # This renames the alias; 'mpv.app alias' -> 'mpv.app'
                    set name of result to \"$(rev <<< "$src" | cut -d'/' -f1 | rev)\"
                end tell
            " 1>/dev/null
        done
  '';

  home-manager = {
    users.${user} =
      { ... }:
      {
        imports = [
          (
            {
              config,
              pkgs,
              lib,
              ...
            }:
            let
              apps = pkgs.buildEnv {
                name = "home-manager-applications";
                paths = config.home.packages;
                pathsToLink = "/Applications";
              };
            in
            {
              # Home-manager does not link installed applications to the user environment. This means apps will not show up
              # in spotlight, and when launched through the dock they come with a terminal window. This is a workaround.
              # Upstream issue: https://github.com/nix-community/home-manager/issues/1341
              home.activation.addApplications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
                echo "setting up ~/Applications/Home Manager Apps..." >&2
                nix_apps="$HOME/Applications/Home Manager Apps Aliases"

                  # Delete the directory to remove old links
                  $DRY_RUN_CMD rm -rf "$nix_apps"
                  $DRY_RUN_CMD mkdir -p "$nix_apps"

                  $DRY_RUN_CMD find ${apps}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
                  while read src; do
                          # Spotlight does not recognize symlinks, it will ignore directory we link to the applications folder.
                          # It does understand MacOS aliases though, a unique filesystem feature. Sadly they cannot be created
                          # from bash (as far as I know), so we use the oh-so-great Apple Script instead.
                          /usr/bin/osascript -e "
                          set fileToAlias to POSIX file \"$src\" 
                          set applicationsFolder to POSIX file \"$nix_apps\"

                          tell application \"Finder\"
                          make alias file to fileToAlias at applicationsFolder
                                  # This renames the alias; 'mpv.app alias' -> 'mpv.app'
                                  set name of result to \"$(rev <<< "$src" | cut -d'/' -f1 | rev)\"
                                  end tell
                                  " 1>/dev/null
                                  done
              '';
            }
          )
        ];
      };
  };
}
