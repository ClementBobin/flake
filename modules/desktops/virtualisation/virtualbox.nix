#
#  Virtualbox
#

{ config, pkgs, vars, ... }:

{
  virtualisation = {
    virtualbox.enable = true;
  };

  users.groups.virtualbox.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    virtualbox                  # Hypervisor type2
  ];
}
