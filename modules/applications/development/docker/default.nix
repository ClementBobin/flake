{ config, pkgs, vars, lib, ... }:

{
  options = {
    docker.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Docker.";
    };

    docker.installMethod = lib.mkOption {
      type = lib.types.str;
      default = "environment";
      description = "Specify the installation method: 'home-manager' or 'environment'.";
    };
  };

  config = lib.mkIf config.docker.enable (
    lib.mkMerge [
      # Installation via home-manager
      (lib.mkIf (config.docker.installMethod == "home-manager") {
        home-manager.users.${vars.user} = {
          home.packages = [ pkgs.docker pkgs.docker-compose ];
        };
      })

      # Installation via environment.systemPackages
      (lib.mkIf (config.docker.installMethod == "environment") {
        users.groups.docker.members = [ "${vars.user}" ];

        virtualisation.docker.enable = true;

        environment.systemPackages = [ pkgs.docker pkgs.docker-compose ];
      })
    ]
  );
}
