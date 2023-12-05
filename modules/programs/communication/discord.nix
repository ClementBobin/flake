#
#  discord
#

{ config, pkgs, vars, ... }:

{
  communication = {
    discord.enable = true;
  };

  users.groups.discord.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    discord                  # discord
  ];
}
