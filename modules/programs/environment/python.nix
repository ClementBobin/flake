#
#  python
#

{ config, pkgs, vars, ... }:

{
  environment = {
    python3.enable = true;
  };

  users.groups.python3.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    python3                  # python
  ];
}
