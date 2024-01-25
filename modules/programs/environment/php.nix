#
#  php
#

{ pkgs, vars, ... }:

{
  users.groups.environment.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    php82Extensions.xdebug
  ];
}