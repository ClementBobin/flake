{ pkgs, vars, ... }:

{
  home-manager.users.${vars.user} = {
    # Configure neovim
    programs.neovim = {

      # Install which-key plugin
      plugins = with pkgs.vimPlugins; [ {
        plugin = which-key-nvim;
        type = "lua";
        config = builtins.readFile ./config.lua;
      }];
    };
  };
}
