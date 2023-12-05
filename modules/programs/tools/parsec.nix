#
#  Parsec
#

{ config, pkgs, vars, ... }:

{
  tools = {
    parsec-bin.enable = true;
  };

  users.groups.parsec-bin.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    parsec-bin                  # Remote desktops 
  ];
}
