#
#  gitkraken
#

{ config, pkgs, vars, ... }:

{
  users.groups.gitkraken.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    gitkraken                  # git UI
  ];
}
