#
#  Virtualbox
#

{ config, pkgs, vars, ... }:

{
  users.groups.hypervisor.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    virtualbox                  # Hypervisor type2
    qemu_kvm # emmulator + hypervisor type 2
    virt-manager # GUI to use KVM
  ];
}
