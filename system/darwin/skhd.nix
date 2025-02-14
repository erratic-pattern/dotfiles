{ pkgs, user, ... }:
let
  inherit (pkgs)
    skhd
    wezterm
    kitty
    slack
    spotify
    ;
in
{
  services.skhd = {
    enable = true;
    package = skhd;
    skhdConfig = ''
      hyper - t : open -a '${wezterm}/Applications/Wezterm.app'
      hyper - n : open -a '${kitty}/Applications/Kitty.app'
      hyper - b : open -a '/Applications/Google Chrome.app'
      hyper - s : open -a '${slack}/Applications/Slack.app'
      hyper - z : open -a '/Applications/zoom.us.app/'
      hyper - m : open -a '${spotify}/Applications/Spotify.app/'
      hyper - p : open -a '/Applications/1Password.app'
      hyper - f : open -a '/System/Library/CoreServices/Finder.app'
    '';
  };

  system.activationScripts.postActivation.text = ''
    echo 'restarting skhd...'
    su - ${user} -c '${skhd}/bin/skhd -r'
  '';
}
