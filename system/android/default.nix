{ ... }:
{
  imports = [
    ./nix.nix
    ./home-manager.nix
  ];

  system = {
    stateVersion = "24.05";
  };
}
