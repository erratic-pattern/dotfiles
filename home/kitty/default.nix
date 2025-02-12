{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;

    extraConfig = ''
      font_family family="Monaspace Argon Var" features="+calt +clig +liga"
      font_size 14

      env WEZTERM_SHELL_SKIP_ALL=1
      env TERMINFO_DIRS=${pkgs.kitty.terminfo.outPath}/share/terminfo

      listen_on unix:/tmp/kitty
      scrollback_lines 10000

      include ${pkgs.kitty-themes}/share/kitty-themes/themes/Nightfox.conf

      map f1 debug_config
      map f2 show_kitty_env_vars
      map f3 dump_lines_with_attrs
    '';

    shellIntegration = {
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    darwinLaunchOptions = [
      "--single-instance"
    ];
  };
}
