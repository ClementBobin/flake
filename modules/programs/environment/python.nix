#
#  python
#

{ config, pkgs, vars, ... }:

{
  users.groups.environment.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    python3                  # python
  ];
}
