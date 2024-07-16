{ ... }: {
  imports = [
    ./git.nix
    ./nvim.nix
    ./packages.nix
    ./tmux.nix
    ./wezterm.nix
    ./zsh.nix
  ];
}
