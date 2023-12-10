#
#  Unity
#

{ pkgs, vars, ... }:

{
  users.groups.engine.members = [ "${vars.user}" ];

  environment.systemPackages = with pkgs; [
    unityhub                  
  ];
}
