#
#  spotify
#

{ config, pkgs, vars, ... }:

{
  app = {
    spotify.enable = true;
  };

  users.groups.spotify.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    spotify                  # Lecteur music
  ];
}
