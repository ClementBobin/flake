{ config, pkgs, vars, lib, ... }:

{
  # Add options for Unity
  options = {
    unity.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable Unity.
      '';
    };

    unity.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install Unity via home-manager or directly in the environment.
      '';
    };
  };

  config = lib.mkIf config.unity.enable (lib.mkMerge [

    # Install Unity if desired
    (lib.mkIf (config.unity.installMethod == "home-manager") {
      home-manager.users.${vars.user} = {
        # Configure Unity
        home.packages = with pkgs; [
          unityhub
        ];
      };
    })

    (lib.mkIf (config.unity.installMethod == "environment") {
      environment.systemPackages = with pkgs; [
        unityhub
      ];
    })

  ]);
}
