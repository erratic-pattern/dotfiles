{ pkgs, user, ... }:
let
  sshAgentPath =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "/Users/${user}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else
      "/home/${user}/.1password/agent.sock";
in
{
  programs._1password-gui.enable = true;
  programs._1password.enable = true;
  programs.ssh = {
    extraConfig = ''
      Host 192.168.*
          IdentityAgent "${sshAgentPath}"
    '';
  };
  # environment.variables = {
  #   SSH_AUTH_SOCK = sshAgentPath;
  # };
}
