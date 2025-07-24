{ pkgs, ... }:
{
  home.packages = with pkgs; [
    firefox
  ];

  programs.firefox = {
    enable = true;
    # package = pkgs.firefox-bin;
    #   profiles.default = {
    #     isDefault = true;
    #     extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    #       # Example extension
    #       ublock-origin
    #
    #     ];
    #   };
  };
}
