#
#  wine
#

{ config, pkgs, vars, ... }:

{
  environment = {
    wine.enable = true;
  };

  users.groups.wine.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
		wine            # wine
    winetricks
  ];
}
