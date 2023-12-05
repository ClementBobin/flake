#
#  libreoffice
#

{ config, pkgs, vars, ... }:

{
  documentation = {
    libreoffice.enable = true;
  };

  users.groups.libreoffice.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    libreoffice                  # Suite documentation
  ];
}
