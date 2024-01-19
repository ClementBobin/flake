#
#  vscode
#

{ pkgs, vars, ... }:

{
 home-manager.users.${vars.user} = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium.fhs;
    };
  };
}
