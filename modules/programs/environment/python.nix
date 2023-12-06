#
#  python
#

{ config, pkgs, vars, ... }:

{
  users.groups.python3.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    python3                  # python
  ];
}
