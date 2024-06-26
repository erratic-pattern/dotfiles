{ ... }:
{
  homebrew = {
    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #

    masApps = {
      # VPN
      "tailscale" = 1475387142;
    };

    brews = [
      # llvm package for using VSCode debugger
      # having issues with nix llvm packages so use brew instead
      "llvm"
    ];

    casks = [
      # Password Manager
      "1password"
      # Communication Apps
      "slack"
      "zoom"
    ];
  };
  # link lldb-vscode and llvm-symbolizer to homebrew bin
  system.activationScripts.linkLlvmCode.text = ''
    ln -f -s $(brew --prefix)/opt/llvm/bin/lldb-vscode $(brew --prefix)/opt/llvm/bin/llvm-symbolizer $(brew --prefix)/bin/
  '';
}
