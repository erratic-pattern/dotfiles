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
    fd
    parallel
    tree
    tmux
    unzip
    watch
    wget
    zip

    # Encryption and security tools
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
    # ffmpeg_5-full

  ];
}
