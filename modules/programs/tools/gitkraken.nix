#
#  gitkraken
#

{ config, pkgs, vars, ... }:

{
  users.groups.tools.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    gitkraken                  # git UI
  ];
}
