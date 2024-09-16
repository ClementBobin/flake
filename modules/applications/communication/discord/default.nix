#Explanation:
#
#    options.discord.enable: A boolean to enable Discord-related packages.
#    options.discord.variant: A boolean to specify if only vesktop should be downloaded.
#    options.discord.custom.list: A list to specify custom packages to be downloaded.
#    config block:
#        Checks if discord.enable is true.
#        Uses lib.optionalAttrs to conditionally add the home.packages attribute.
#        Constructs the list of packages based on the variant and custom.list options.
#
#This setup ensures that:
#
#    Setting option.discord.enable = true with option.discord.variant = true will only download vesktop.
#    Setting option.discord.custom.list = ["discord", "vesktop"] will download both packages.
#    Setting option.discord.enable = true without any other options will download only discord.
#
#You can now use the options in your configuration as needed. For example:
#
#{
#  discord.enable = true;
#  discord.variant = true;  # This will download only vesktop
#}
#
#{
#  discord.enable = true;
#  discord.custom.list = ["discord", "vesktop"];  # This will download both discord and vesktop
#}
#
#{
#  discord.enable = true;  # This will download only discord
#}
#
#This approach gives you the flexibility to control the installation of packages based on your requirements.

{ config, pkgs, vars, lib, ... }:

{
  # Add options for Discord
  options = {
    discord.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable Discord.
      '';
    };

    discord.variant = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable only Vesktop instead of Discord.
      '';
    };

    discord.custom.list = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = ''
        Custom list of packages to install.
      '';
    };

    discord.installMethod = lib.mkOption {
      type = lib.types.str;
      default = "home-manager";
      description = ''
        Specify the installation method: "home-manager" or "environment".
      '';
    };
  };

  # Configuration based on install method
  config = lib.mkIf config.discord.enable (
    let
      basePackages = if config.discord.variant then [ pkgs.vesktop ] else [ pkgs.discord ];
      customPackages = map (pkg: pkgs.${pkg}) config.discord.custom.list;
      allPackages = basePackages ++ customPackages;
    in
    {
      home-manager.users.${vars.user} = lib.mkIf (config.discord.installMethod == "home-manager") {
        home.packages = allPackages;
      };

      environment.systemPackages = lib.mkIf (config.discord.installMethod == "environment") (
        allPackages
      );
    }
  );
}


