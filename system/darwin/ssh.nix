{ ... }:
{
  services.openssh = {
    enable = true;
  };

  # home.sessionVariables = {
  #   SSH_AUTH_SOCK = sshAgentPath;
  # };
}
