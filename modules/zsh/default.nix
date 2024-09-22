{ config, lib, pkgs, vars, ... }:

{
  # Add options for zsh
  options = {
    zsh.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable zsh.
      '';
    }; 
  };

  # Install and configure zsh if desired
  config = lib.mkIf config.zsh.enable {
    home-manager.users.${vars.user} = {
      # Configure zsh shell
      programs.zsh = {

        # Enable zsh
        enable = true;

        # Enable zsh features
        enableCompletion = true;
        #autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
        enableVteIntegration = true;

        # Configure shell aliases for zsh
        shellAliases = {

          # Run things with XWayland easily
          run-with-xwayland = "env -u WAYLAND_DISPLAY";
        };

        oh-my-zsh = {                               # Plug-ins
          enable = true;
          plugins = [ "git" ];
        };

        initExtra = ''
          # Spaceship
          source ${pkgs.spaceship-prompt}/share/zsh/site-functions/prompt_spaceship_setup
          autoload -U promptinit; promptinit
          # Hook direnv
          emulate zsh -c "$(direnv hook zsh)"

          eval "$(direnv hook zsh)"
        '';      

        # Install plugins
        plugins = [

          # Vi keybindings
          {
            name = "zsh-vi-mode";
            file = "./share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
            src = pkgs.zsh-vi-mode;
          }

          # Autosuggestions
          {
            name = "zsh-autosuggestions";
            file = "./share/zsh-autosuggestions/zsh-autosuggestions.zsh";
            src = pkgs.zsh-autosuggestions;
          }
        ];
      };
    };
  };
}
