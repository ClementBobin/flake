#
#  teams-for-linux
#

{ config, pkgs, vars, lib, ... }:

{
  # Add options for teams-for-linux
  options = {
    teams-for-linux.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable teams-for-linux.
      '';
    };

    teams-for-linux.installMethod = lib.mkOption {
      type = lib.types.str;
      default = "home-manager";
      description = ''
        Specify the installation method: "home-manager" or "environment".
      '';
    };
  };

  # Configuration based on install method
  config = lib.mkIf config.teams-for-linux.enable {
    home-manager.users.${vars.user} = {
      home.packages = with pkgs; [
        teams-for-linux
      ];
    };
  };
}
