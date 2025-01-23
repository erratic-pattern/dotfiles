{ pkgs, user, home-manager, nix-homebrew, ... }:
{
  imports = [
    home-manager.darwinModules.home-manager
    nix-homebrew.darwinModules.nix-homebrew
    ./shell.nix
    ./fonts.nix
    ./homebrew.nix
    ./spotlight-fix.nix
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
        ApplePressAndHoldEnabled = true;
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

      # Control Center / Menu Bar
      controlcenter = {
        Bluetooth = true; # Show bluetooth icon in menu bar
      };
    };

    keyboard = {
      enableKeyMapping = true;
    };
  };
}
