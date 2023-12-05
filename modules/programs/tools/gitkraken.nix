#
#  gitkraken
#

{ config, pkgs, vars, ... }:

{
  tools = {
    gitkraken.enable = true;
  };

  users.groups.gitkraken.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    gitkraken                  # git UI
  ];
}
