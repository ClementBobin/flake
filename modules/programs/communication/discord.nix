#
#  discord
#

{ config, pkgs, vars, ... }:

{
  users.groups.communication.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    discord                  # discord
  ];
}
