#
#  jetbrain
#

{ pkgs, vars, ... }:

{
 home-manager.users.${vars.user} = {
    programs.jetbrains.rider = {
      enable = true;
    };
  };
}
