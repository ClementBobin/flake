#
#  nodejs
#

{ config, pkgs, vars, ... }:

{
  users.groups.nodejs_20.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    nodejs_20                  # nodejs
  ];
}
