{ config, pkgs, vars, lib, ... }:

{
  # Add options for Node.js
  options = {
    nodejs.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable Node.js.
      '';
    };
    nodejs.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install Node.js via home-manager or directly in the environment.
      '';
    };
  };

  # Install Node.js if desired
  config = lib.mkIf config.nodejs.enable (lib.mkMerge [

    # Node.js config for home-manager
    (lib.mkIf (config.nodejs.installMethod == "home-manager") {
      home-manager.users.${vars.user} = {
        # Install Node.js packages
        home.packages = with pkgs; [
          nodejs_20                  # Node.js
          nodePackages.vercel        # Vercel CLI
          graphite-cli               # Graphite terminal
          commitlint
          corepack_22                # Corepack (commit help)
        ];
      };
    })

    # Node.js config for environment
    (lib.mkIf (config.nodejs.installMethod == "environment") {
      environment.systemPackages = with pkgs; [
        nodejs_20                  # Node.js
        nodePackages.vercel        # Vercel CLI
        graphite-cli               # Graphite terminal
        commitlint
        corepack_22                # Corepack (commit help)
      ];
    })
  ]);
}
