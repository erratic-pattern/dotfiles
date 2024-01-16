{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # General packages for development and system management
    bash-completion
    coreutils
    jq
    killall
    openssh
    ripgrep
    tree
    tmux
    unzip
    wget
    zip

    # Encryption and security tools
    _1password
    gnupg
    # libfido2
    # pinentry
    # yubikey-manager

    # Source code management, Git, GitHub tools
    gh
    git

    # VS Code CLI
    # vscode

    # Fonts
    fira-code
    fira-code-nerdfont

    # Video Tools
    ffmpeg_5-full # see https://github.com/NixOS/nixpkgs/issues/271313

  ];
}
