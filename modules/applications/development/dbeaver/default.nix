{ config, pkgs, vars, lib, ... }:

{
  # Add options for dbeaver
  options = {
    dbeaver.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable dbeaver.
      '';
    };

    dbeaver.installMethod = lib.mkOption {
      type = lib.types.str;
      default = "home-manager";
      description = ''
        Specify the installation method: "home-manager" or "environment".
      '';
    };
  };

  # Configuration based on install method
  config = lib.mkIf config.dbeaver.enable {
    home-manager.users.${vars.user} = lib.optionalAttrs (config.dbeaver.installMethod == "home-manager") {
      home.packages = with pkgs; [
        dbeaver-bin
        azuredatastudio
      ];
    };
  };
}
