{ config, lib, pkgs, vars, ... }:

{
  # Add options for neovim
  options = {
    neovim.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable neovim.
      '';
    };

    neovim.installMethod = lib.mkOption {
      type = lib.types.enum [ "home-manager" "environment" ];
      default = "home-manager";
      description = ''
        Choose whether to install and configure neovim via home-manager or directly in the system environment.
      '';
    };
  };

  # Install and configure neovim if desired
  config = lib.mkIf config.neovim.enable (lib.mkMerge [

    # Neovim configuration for home-manager
    (lib.mkIf (config.neovim.installMethod == "home-manager") {
      home-manager.users.${vars.user} = {
        # Configure neovim
        programs.neovim = {
          enable = true;
          vimAlias = true;
          vimdiffAlias = true;
          withPython3 = true;

          # General configuration for neovim
          extraLuaConfig = builtins.readFile ./config.lua;
        };

        # Import plugins with customisation
        imports = [
          ./plugins/dashboard
          ./plugins/barbar
          ./plugins/lsp
          ./plugins/nvim-treesitter
          ./plugins/nvim-cmp
          ./plugins/leap
          ./plugins/nvim-comment
          ./plugins/nvim-surround
          ./plugins/trim
          ./plugins/nvim-tree
          ./plugins/telescope
          ./plugins/gitsigns
          ./plugins/lualine
          ./plugins/cursorline
          ./plugins/fidget
          ./plugins/true-zen
          #./plugins/wilder
          #./plugins/which-key
        ];
      };
    })

    # Neovim configuration for system environment
    (lib.mkIf (config.neovim.installMethod == "environment") {
      environment.systemPackages = with pkgs; [
        neovim
      ];

      # Ensure Neovim is configured (you might need to provide a configuration file)
      # Note: Direct system environment configuration might need additional steps
      # Place the init.lua in the expected location
      environment.etc."nvim/init.lua".text = builtins.readFile ./config.lua;

      # Import plugins by specifying paths directly in the Neovim configuration
      # (Use `extraConfig` for system-wide configuration if needed)
    })

  ]);
}
