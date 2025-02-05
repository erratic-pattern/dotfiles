{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Shell utilities
    bash-completion
    coreutils
    difftastic
    fd
    jq
    killall
    parallel
    ripgrep
    tmux
    tree
    unzip
    watch
    wget
    zip

    # System Management
    btop
    glances
    htop

    # Encryption and security tools
    openssh
    _1password-cli
    gnupg
    # libfido2
    # pinentry
    # yubikey-manager

    # Debugging tools
    # llvmPackages.lldb
    # llvmPackages.libllvm

    # Source code management, Git, GitHub tools
    gh
    git

    # VS Code CLI
    # vscode

    # Video Tools
    ffmpeg-full

    # Nix tools
    cached-nix-shell
  ];
}
