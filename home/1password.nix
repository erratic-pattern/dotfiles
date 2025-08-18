{ pkgs, config, ... }:
let
  sshAgentPath =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else
      "${config.home.homeDirectory}/.1password/agent.sock";
in
{
  # SSH configuration for 1Password agent
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent "${sshAgentPath}"
    '';
  };

  # Create 1Password askpass helper script
  home.file.".local/bin/1password-askpass" = {
    text = ''
      #!/bin/bash
      ${pkgs._1password-cli}/bin/op read "op://Personal/Adams-MacBook/password" 2>/dev/null
    '';
    executable = true;
  };

  # 1Password SSH agent configuration
  xdg.configFile."1password/ssh/agent.toml".text = ''
    [[ssh-keys]]
    vault = "Keys"
  '';

  home.sessionVariables = {
    # Set 1Password as askpass helper for GUI sudo prompts
    SUDO_ASKPASS = "${config.home.homeDirectory}/.local/bin/1password-askpass";
    # Set SSH_AUTH_SOCK to use 1Password SSH agent globally
    SSH_AUTH_SOCK = "${sshAgentPath}";
  };

  # Ensure .local/bin is in PATH
  home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];
}
