_: { config, lib, pkgs, ... }:

{
  # Install starship if desired
  config = lib.mkIf config.starship.enable {

    # Configure starship prompt for various shells
    programs.starship = {

      # Enable starship
      enable = true;
    };
  };
}
