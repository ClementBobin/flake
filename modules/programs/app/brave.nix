#
#  brave
#

{ config, pkgs, vars, ... }:

{
  app = {
    brave.enable = true;
  };

  users.groups.brave.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    brave                  # Navigator Web
  ];
}
