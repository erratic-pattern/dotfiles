{ pkgs, ... }:
let
  icon = pkgs.fetchFromGitHub {
    owner = "diegobit";
    repo = "kitty-icon";
    rev = "main";
    sha256 = "sha256-vZCNNVfdCTYPiSSXtug7xfW3c0Cx/H0S3w+f1q3Prgs=";
  };
in
{
  # Customize icon
  xdg.configFile =
    if pkgs.stdenv.hostPlatform.isDarwin then
      {
        "kitty/kitty.app.icns".source = "${icon}/kitty.icns";
      }
    else
      {
        "kitty/kitty.app.png".source = "${icon}/kitty.png";
      };
  programs.kitty = {
    enable = true;

    extraConfig = ''
      font_family family="Monaspace Argon Var" variable_name=MonaspaceArgonVar features="+calt +liga"
      font_size 14

      env WEZTERM_SHELL_SKIP_ALL=1
      env TERMINFO_DIRS=${pkgs.kitty.terminfo.outPath}/share/terminfo

      listen_on unix:/tmp/kitty
      scrollback_lines 10000

      macos_quit_when_last_window_closed yes

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
