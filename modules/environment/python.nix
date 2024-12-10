{ config, pkgs, vars, lib, ... }:

{
  # Add options for Python
  options = {
    python.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable Python.
      '';
    };

    python.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install Python via home-manager or directly in the environment.
      '';
    };
  };

  # Install Python if desired
  config = lib.mkIf config.python.enable (lib.mkMerge [

    # Python config for home-manager
    (lib.mkIf (config.python.installMethod == "home-manager") {
      home-manager.users.${vars.user} = {
        # Configure Python packages
        home.packages = with pkgs; [
          python311
          #python311Packages.pipx
        ];
      };
    })

    # Python config for environment
    (lib.mkIf (config.python.installMethod == "environment") {
      environment.systemPackages = with pkgs; [
        python311
        python311Packages.pipx
      ];
    })
  ]);
}
