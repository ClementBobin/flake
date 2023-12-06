#
#  spotify
#

{ config, pkgs, vars, ... }:

{
  users.groups.spotify.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    spotify                  # Lecteur music
  ];
}
