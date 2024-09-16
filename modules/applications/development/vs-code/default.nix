{ config, lib, pkgs, vars, ... }:

{
  # Add options for vs-code
  options = {
    vs-code.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable vs-code.
      '';
    }; 
  };

  # Install vs-code if desired
  config = lib.mkIf config.vs-code.enable {
    home-manager.users.${vars.user} = {
      # Configure Visual Studio Code
      programs.vscode = {

        # Enable VS Code
        enable = true;

        # Install extensions
        extensions = with pkgs.vscode-extensions; [

          # Utility
          ms-vsliveshare.vsliveshare
          shardulm94.trailing-spaces
          vscodevim.vim
          xaver.clang-format
          humao.rest-client

          # Languages
          bbenoist.nix
          haskell.haskell
          ms-vscode.cpptools
          ms-dotnettools.csharp
          yzhang.markdown-all-in-one

          #aerokaido.three-js-snippets
          #abusaidm.html-snippets
          alefragnani.project-manager
          #endormi.2077-theme
          #pnp.polacode
          github.vscode-github-actions
          #ms-azuretools.vscode-azurestaticwebapps
          #ms-vscode.azure-account
          esbenp.prettier-vscode
          #dsznajder.es7-react-js-snippets
          #pranaygp.vscode-css-peek
          #ms-dotnettools.vscodeintellicode-csharp
          #ms-dotnettools.vscode-dotnet-runtime
          marp-team.marp-vscode
          #ryanluker.vscode-coverage-gutters
          github.vscode-pull-request-github
          ms-azuretools.vscode-docker
          ms-vscode-remote.remote-wsl
          #anbuselvanrocky.bootstrap5-vscode
          #yclepticstudios.unity-snippets
          aaron-bond.better-comments
          wmaurer.change-case
          streetsidesoftware.code-spell-checker
          #k--kato.docomment
          #fudge.auto-using
          #revrenlove.c-sharp-utilities
          #amlovey.shaderlabvscodefree
          #slevesque.shader
          #timgjones.hlsltools
          #fabriciohod.unity-dev-pack
          #diegosarmentero.unity-dots-snippets
          ms-vscode-remote.remote-containers
          johnpapa.vscode-peacock
          usernamehw.errorlens
          formulahendry.auto-rename-tag
          #orta.vscode-jest
          christian-kohler.path-intellisense
          visualstudioexptteam.intellicode-api-usage-examples
          visualstudioexptteam.vscodeintellicode
          ms-vscode.live-server
          ms-python.python
          ms-python.vscode-pylance
          #ms-azuretools.vscode-azureresourcegroups
          #akmarnafi.comment-headers
          #nicholashsiang.vscode-javascript-comment
          #vivaxy.vscode-conventional-commits
          bradlc.vscode-tailwindcss
          firsttris.vscode-jest-runner
          #yandeu.five-server
          pkief.material-icon-theme
          #alexey-glazov.cool-graphite-and-turquoise
          #joshbolduc.commitlint
          #visualstudiotoolsforunity.vstuc
          ms-dotnettools.csdevkit   # failed
          ms-dotnettools.csharp
          ms-vsliveshare.vsliveshare
          #graphite.gti-vscode
          #blackboxapp.blackbox
          #GitHub.codespaces
          #GitHub.copilot
          #GitHub.copilot-chat
        ];
      };

      # Ensure the script runs during activation
      home.activation.install-vscode-extensions = lib.mkAfter ''
        ${pkgs.writeScript "install-vscode-extensions.sh" (builtins.readFile ./scripts/install-vscode-extensions.sh)}
      '';

      # Add config file for VS Code
      xdg.configFile."Code/User/settings.json" = {
        text = ''
          {
            "editor.fontFamily": "'FiraCode Nerd Font', monospace",
            "editor.tabSize": 2,
            "editor.wordWrap": "wordWrapColumn",
            "explorer.confirmDelete": false,
            "git.confirmSync": false,
            "window.menuBarVisibility": "toggle",
            "window.zoomLevel": 1,
            "workbench.startupEditor": "none",
            "github.copilot.editor.enableAutoCompletions": true,
            "workbench.productIconTheme": "emoji-product-icons",
            "workbench.iconTheme": "material-icon-theme",
            "git.autofetch": true,
            "window.zoomLevel": 2,
            "workbench.colorTheme": "2077",
            "typescript.updateImportsOnFileMove.enabled": "always",
            "javascript.updateImportsOnFileMove.enabled": "always",
            "cSpell.userWords": [
                "Devis",
                "GETDATE",
                "l'Etat"
            ],
            "git.openRepositoryInParentFolders": "never"
          }
        '';
      };
    };
  };
}
