#
#  qemu
#

{ config, pkgs, vars, ... }:

{
  users.groups.hypervisor.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    qemu_kvm # emmulator + hypervisor type 2
    virt-manager # GUI to use KVM
  ];
}
