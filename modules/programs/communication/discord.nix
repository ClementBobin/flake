#
#  discord
#

{ config, pkgs, vars, ... }:

{
  users.groups.discord.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    discord                  # discord
  ];
}
