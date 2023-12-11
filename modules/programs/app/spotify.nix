#
#  spotify
#

{ config, pkgs, vars, ... }:

{
  users.groups.app.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    spotify                  # Lecteur music
  ];
}
