{ pkgs, ... }:
let
  podman-mac-helper = import ./podman-mac-helper.nix { inherit pkgs; };
in
{
  # 1Password CLI and integration tools
  environment.systemPackages = with pkgs; [
    _1password-cli
    podman-mac-helper
    
    # Podman container runtime and related tools
    podman
    podman-tui
    podman-desktop
    podman-bootc
    podman-compose
  ];

  # Docker build environment variable
  environment.variables = {
    DOCKER_BUILDKIT = "1";
  };

  # Create symlinks for 1Password and Podman integration
  system.activationScripts.postActivation.text = ''
    echo 'creating podman symlinks...'
    mkdir -p /usr/local/bin
    
    # Podman CLI tools
    ln -sf ${pkgs.podman}/bin/podman /usr/local/bin/podman
    ln -sf ${pkgs.podman-compose}/bin/podman-compose /usr/local/bin/podman-compose
    
    # Podman-mac-helper with 1Password askpass integration
    ln -sf ${podman-mac-helper}/bin/podman-mac-helper /usr/local/bin/podman-mac-helper
  '';
}