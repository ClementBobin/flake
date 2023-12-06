#
#  Parsec
#

{ config, pkgs, vars, ... }:

{
  users.groups.parsec-bin.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    parsec-bin                  # Remote desktops 
  ];
}
