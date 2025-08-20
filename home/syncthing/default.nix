{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    syncthing
  ];

  services.syncthing = {
    enable = true;

    settings = {
      devices = {
        alexandria = {
          id = "DNKOF4K-O6MBCKU-YYGMS7L-2TGO5C6-GKT7IEC-6RLVIWD-LPVBHQZ-R7Y7VQS";
        };
        SM-S9228U1 = {
          id = "G7TMR43-HV5HYVA-V3UTMKP-RUMNQBM-J6AT7GK-QT7EV2C-SJ344AG-S5MDXQK";
        };
      };

      # Folder configuration
      folders = {
        "books" = {
          path = "${config.home.homeDirectory}/Books";
          id = "books-sync";
          devices = [ "alexandria" ]; # Share with alexandria
        };
        "notes" = {
          path = "${config.home.homeDirectory}/Notes";
          id = "rzdgt-rvrfr";
          devices = [ "SM-S9228U1" ]; # Share with SMS9228U1
        };
      };
    };
  };
}
