{ pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
    # Configure neovim
    programs.neovim = {

      # Install fidget for nvim
      plugins = with pkgs.vimPlugins; [{
        plugin = fidget-nvim;
        type = "lua";
        config = ''
          ----------------------------------
          -- fidget
          ----------------------------------

          require('fidget').setup({})
        '';
      }];
    };
  };
}
