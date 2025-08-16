{ pkgs, ... }:

pkgs.writeShellApplication {
  name = "podman-mac-helper";
  text = ''
    # Simple podman-mac-helper implementation for Nix
    # This script manages Docker socket compatibility for Podman
    # Uses 1Password for privilege escalation when needed

    DOCKER_SOCKET="/var/run/docker.sock"

    find_podman_socket() {
        # Find the Podman API socket dynamically
        find /var/folders -name "*podman*api.sock" 2>/dev/null | head -1
    }

    case "''${1-}" in
        install)
            echo "Installing Docker socket compatibility..."
            PODMAN_API_SOCKET=$(find_podman_socket)
            
            if [ -S "$PODMAN_API_SOCKET" ]; then
                # Use sudo with 1Password askpass for privilege escalation
                if [ -x "$HOME/.local/bin/1password-askpass" ]; then
                    export SUDO_ASKPASS="$HOME/.local/bin/1password-askpass"
                    sudo -A ln -sf "$PODMAN_API_SOCKET" "$DOCKER_SOCKET"
                else
                    # Fallback to regular sudo if 1Password askpass not available
                    sudo ln -sf "$PODMAN_API_SOCKET" "$DOCKER_SOCKET"
                fi
                echo "Docker socket symlink created: $DOCKER_SOCKET -> $PODMAN_API_SOCKET"
            else
                echo "Error: Podman API socket not found"
                echo "Make sure Podman machine is running: podman machine start"
                exit 1
            fi
            ;;
        uninstall)
            echo "Removing Docker socket compatibility..."
            # Use sudo with 1Password askpass for privilege escalation
            if [ -x "$HOME/.local/bin/1password-askpass" ]; then
                export SUDO_ASKPASS="$HOME/.local/bin/1password-askpass"
                sudo -A rm -f "$DOCKER_SOCKET"
            else
                # Fallback to regular sudo if 1Password askpass not available
                sudo rm -f "$DOCKER_SOCKET"
            fi
            echo "Docker socket symlink removed"
            ;;
        *)
            echo "Usage: $0 {install|uninstall}"
            echo "  install   - Create Docker socket symlink for compatibility"
            echo "  uninstall - Remove Docker socket symlink"
            exit 1
            ;;
    esac
  '';
}