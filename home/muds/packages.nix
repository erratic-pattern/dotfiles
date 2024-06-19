{ pkgs, ... }: {
  home.packages = with pkgs; [
    # GUI MUD client
    mudlet
  ];
}
