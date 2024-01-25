#
#  Docker
#

{ config, pkgs, vars, ... }:

{
  users.groups.hypervisor.members = [ "${vars.user}" ];

  virtualisation.podman = {
    enable = true;
    dockerSocket.enable = true;
    networkSocket.enable = true;
  };

  environment.systemPackages = with pkgs; [
    podman-compose
    podman-desktop
  ];
}
