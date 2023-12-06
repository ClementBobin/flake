#
#  brave
#

{ config, pkgs, vars, ... }:

{
  users.groups.brave.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    brave                  # Navigator Web
  ];
}