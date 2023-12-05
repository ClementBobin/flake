#
#  Unity
#

{ pkgs, vars, ... }:

{
 home-manager.users.${vars.user} = {
    programs = {
      unityhub = {
        enable = true;
      };
      inkscape = {
        enable = true;
      };
    };
  };
}
