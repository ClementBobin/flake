#
#  Parsec
#

{ config, pkgs, vars, ... }:

{
  users.groups.tools.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    parsec-bin                  # Remote desktops 
  ];
}
