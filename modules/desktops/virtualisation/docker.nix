#
#  Docker
#

{ config, pkgs, vars, ... }:

{
  users.groups.hypervisor.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    docker                  # Containers
    docker-compose          # Multi-Container
  ];
}