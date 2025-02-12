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
        ../home/nvim
        ../home/shell
        ../home/directories.nix
      ];
    };
  };
}
