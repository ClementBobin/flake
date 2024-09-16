#
#  Power Management
#

{ config, lib, pkgs, vars, ... }:

{
  # Add options for laptop
  options = {
    laptop.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable laptop.
      '';
    }; 
  };

  config = lib.mkIf ( config.laptop.enable ) {
    services = {
      power-profiles-daemon.enable = true;                          # Power Efficiency
      #auto-cpufreq.enable = true;
    };

    home-manager.users.${vars.user} = {
      services = {
        cbatticon = {                             # Battery Level Notifications
          enable = true;
          criticalLevelPercent = 10;
          commandCriticalLevel = ''notify-send "battery critical!"'';
          lowLevelPercent = 30;
          iconType = "standard";
        };
      };
    };
  };
}
