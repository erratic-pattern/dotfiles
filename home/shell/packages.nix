{ pkgs, lib, ... }:
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
  ];
}
