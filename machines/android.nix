{ ... }:
{
  imports = [
    ../system/android
  ];

  home-manager = {
    config = {
      imports = [
        ../home/influx
        ../home/mud
        ../home/neovim
        ../home/shell
        ../home/directories.nix
      ];
    };
  };
}
