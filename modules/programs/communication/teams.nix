#
#  teams-for-linux
#

{ config, pkgs, vars, ... }:

{
  users.groups.communication.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    teams-for-linux                  # Teams
  ];
}
