#
#  wine
#

{ config, pkgs, vars, ... }:

{
  users.groups.wine.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
		wine            # wine
    winetricks
  ];
}
