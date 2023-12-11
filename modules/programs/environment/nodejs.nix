#
#  nodejs
#

{ config, pkgs, vars, ... }:

{
  users.groups.environment.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    nodejs_20                  # nodejs
  ];
}
