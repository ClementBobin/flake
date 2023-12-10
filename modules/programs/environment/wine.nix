#
#  wine
#

{ config, pkgs, vars, ... }:

{
  users.groups.environment.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
		wine            # wine
    winetricks
  ];
}
