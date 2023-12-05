#
#  nodejs
#

{ config, pkgs, vars, ... }:

{
  environment = {
    nodejs_20.enable = true;
  };

  users.groups.nodejs_20.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    nodejs_20                  # nodejs
  ];
}
