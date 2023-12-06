#
#  teams-for-linux
#

{ config, pkgs, vars, ... }:

{
  users.groups.teams-for-linux.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    teams-for-linux                  # Teams
  ];
}
