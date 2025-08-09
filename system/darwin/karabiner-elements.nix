{ pkgs, user, ... }: 
{
  services.karabiner-elements = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    goku
  ];
  home-manager.users.${user} = {
  };
}
   
