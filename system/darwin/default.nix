{ config, pkgs, lib, user, home-manager, nix-homebrew, ... }:
{
  imports = [
    home-manager.darwinModules.home-manager
    nix-homebrew.darwinModules.nix-homebrew
    ./shell.nix
    ./fonts.nix
    ./homebrew.nix
    ./dock.nix
    ../common
  ];

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  system = {
    stateVersion = 4;

    defaults = {
      # trust files from network
      LaunchServices = {
        LSQuarantine = false;
      };

      # Enable firewall
      alf.globalstate = 1;

      NSGlobalDomain = {
        AppleShowAllExtensions = true;

        # press and hold to repeat key
        ApplePressAndHoldEnabled = false;
        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;
        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        # use F1, F2, etc. keys as standard function keys
        "com.apple.keyboard.fnState" = true;

        # tap to click
        "com.apple.mouse.tapBehavior" = 1;

        # disable natural scrolling
        "com.apple.swipescrolldirection" = false;

        # no beeps
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;

        # dark mode
        AppleInterfaceStyle = "Dark";

        # full keyboard UI control 
        AppleKeyboardUIMode = 3;

        NSDocumentSaveNewDocumentsToCloud = false;
      };

      dock = {
        autohide = true;
        show-recents = false;
        launchanim = true;
        mouse-over-hilite-stack = true;
        orientation = "bottom";
        tilesize = 48;
        minimize-to-application = true;
      };

      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = false;
        ShowStatusBar = true;
        ShowPathbar = true;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = false;
        ActuationStrength = 0;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      # remapCapsLockToControl = true;
    };
  };

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
        chown $USER: "$applications"
        chmod u+w "$applications"
    fi

    # Delete the directory to remove old links
    rm -rf "$nix_apps"
    mkdir -p "$nix_apps"
    find ${config.system.build.applications}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
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
