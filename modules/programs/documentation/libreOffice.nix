#
#  libreoffice
#

{ config, pkgs, vars, ... }:

{
  users.groups.libreoffice.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    libreoffice                  # Suite documentation
  ];
}
