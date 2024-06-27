#
#  Docker
#

{ config, pkgs, vars, ... }:

{
  users.groups.docker.members = [ "${vars.user}" ];

  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
