#
#  teams-for-linux
#

{ config, pkgs, vars, ... }:

{
  communication = {
    teams-for-linux.enable = true;
  };

  users.groups.teams-for-linux.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    teams-for-linux                  # Teams
  ];
}
