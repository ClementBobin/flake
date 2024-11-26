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

  # VS Code configuration, conditional on vs-code.enable
  config = lib.mkIf config.vs-code.enable {

    # Set XDG desktop variable globally
    environment.variables.XDG_CURRENT_DESKTOP = "KDE:GNOME";

    # Home Manager configuration for VS Code
    home-manager.users.${vars.user} = {

    programs.vscode = {
      enable = true;
    };

      # Activate extension installation script
      home.activation.install-vscode-extensions = lib.mkAfter ''
        ${pkgs.writeScript "install-vscode-extensions.sh" (builtins.readFile ./scripts/install-vscode-extensions.sh)}
      '';

      # Add config file for VS Code
      xdg.configFile."Code/User/settings.json" = {
        text = ''
          {
            "github.copilot.editor.enableAutoCompletions": true,
            "workbench.productIconTheme": "emoji-product-icons",
            "workbench.iconTheme": "material-icon-theme",
            "git.autofetch": true,
            "window.zoomLevel": 4,
            "workbench.colorTheme": "Dracula Theme",
            "typescript.updateImportsOnFileMove.enabled": "always",
            "javascript.updateImportsOnFileMove.enabled": "always",
            "cSpell.userWords": [
                "Devis",
                "GETDATE",
                "l'Etat"
            ],
            "git.openRepositoryInParentFolders": "never",
            "dotnet-test-explorer.testArguments": "/p:CollectCoverage=true /p:CoverletOutputFormat=lcov /p:CoverletOutput=./lcov.info",
            "dotnet-test-explorer.testProjectPath": "*/*.Tests.csproj",
            "dotnet-test-explorer.autoExpandTree": true,
            "dotnet-test-explorer.autoWatch": true,
            "dotnet-test-explorer.enableTelemetry": false,
            "coverage-gutters.showLineCoverage": true,
            "coverage-gutters.highlightdark": "rgba(172, 0, 161, 0.35)",
            "coverage-gutters.highlightlight": "rgba(172, 0, 161, 0.35)",
            "coverage-gutters.noHighlightDark": "rgba(255, 0, 0, 0.5)",
            "coverage-gutters.noHighlightLight": "rgba(255, 0, 0, 0.5)",
            "coverage-gutters.coverageFileNames": [
                "lcov.info",
                "cov.xml",
                "coverage.xml",
                "jacoco.xml",
                "coverage.cobertura.xml",
                "coverage.json"
            ],
            "coverage-gutters.partialHighlightDark": "rgba(255, 128, 0, 0.5)",
            "coverage-gutters.partialHighlightLight": "rgba(255, 128, 0, 0.5)",
            "coverage-gutters.showGutterCoverage": false,
            "coverage-gutters.showRulerCoverage": true,
            "coverage-gutters.remotePathResolve": [

            ],
            "git.confirmSync": false,
            "git.enableSmartCommit": true,
            "workbench.statusBar.visible": false,
            "files.autoSave": "onFocusChange",
            "editor.minimap.enabled": false,
            "workbench.sideBar.location": "right",

            // custom
            "editor.copyWithSyntaxHighlighting": false,
            "diffEditor.ignoreTrimWhitespace": false,
            "editor.emptySelectionClipboard": false,
            "workbench.editor.enablePreview": false,
            "window.newWindowDimensions": "inherit",
            "editor.multiCursorModifier": "ctrlCmd",
            "files.trimTrailingWhitespace": true,
            "diffEditor.renderSideBySide": false,
            "editor.snippetSuggestions": "top",
            "editor.detectIndentation": false,
            //"window.nativeFullScreen": true,
            "files.insertFinalNewline": true,
            "files.trimFinalNewlines": true,
            //"workbench.editor.showTabs": "none",
            //"editor.lineNumbers": "off",
            "editor.guides.indentation": false,

            // Silence the Noise
            "breadcrumbs.enabled": true,
            "scm.diffDecorations": "none",
            "editor.hover.delay": 1500,
            "editor.hover.enabled": true,
            "editor.matchBrackets": "never",
            "workbench.tips.enabled": false,
            "editor.colorDecorators": false,
            "git.decorations.enabled": false,
            "workbench.startupEditor": "none",
            //"editor.lightbulb.enabled": "off",
            "editor.selectionHighlight": false,
            "editor.overviewRulerBorder": false,
            "editor.renderLineHighlight": "none",
            "editor.occurrencesHighlight": "off",
            "problems.decorations.enabled": false,
            "editor.renderControlCharacters": false,
            "editor.hideCursorInOverviewRuler": true,
            "editor.gotoLocation.multipleReferences": "goto",
            "editor.gotoLocation.multipleDefinitions": "goto",
            "editor.gotoLocation.multipleDeclarations": "goto",
            "workbench.editor.enablePreviewFromQuickOpen": false,
            "editor.gotoLocation.multipleImplementations": "goto",
            "editor.gotoLocation.multipleTypeDefinitions": "goto",

            // Typography
            "editor.fontFamily": "Geist Mono, JetBrains Mono, Fira Code",
            "editor.suggestFontSize": 16,
            "editor.suggestLineHeight": 30,
            "terminal.integrated.lineHeight": 1.5,
            "terminal.integrated.fontSize": 16,

            "search.useIgnoreFiles": false,
            "search.exclude": {
                // Hide everything in /vendor, except the "laravel" and "livewire" folder.
                "**/vendor/{[^l],?[^ai]}*": true,
                // Hide everything in /public, except "index.php"
                "**/public/{[^i],?[^n]}*": true,
                "**/node_modules": true,
                "**/dist": true,
                "**/_ide_helper.php": true,
                "**/composer.lock": true,
                "**/package-lock.json": true,
                "storage": true,
                ".phpunit.result.cache": true
            },

            /**
            * Code
            **/
            // Include "-" in word selection.
            "editor.wordSeparators": "`~!@#%^&*()=+[{]}\\|;:'\",.<>/?",
            "emmet.includeLanguages": {
                "blade": "html",
                "vue-html": "html",
                "vue": "html",
                "react": "html",
                "javascript": "html"
            },
            "files.associations": {
                ".php_cs": "php",
                ".php_cs.dist": "php"
            },

            /**
            * PHP
            **/
            "php.suggest.basic": false,

            /**
            * Prettier
            **/
            "[javascript]": {
                "editor.defaultFormatter": "esbenp.prettier-vscode",
                "editor.formatOnSave": true
            },
            "[typescriptreact]": {
                "editor.defaultFormatter": "esbenp.prettier-vscode",
                "editor.formatOnSave": true
            },
            "[tailwindcss]": {
                "editor.defaultFormatter": "esbenp.prettier-vscode",
                "editor.formatOnSave": true
            },
            "[vue]": {
                "editor.defaultFormatter": "esbenp.prettier-vscode",
                "editor.formatOnSave": true
            },
            "[javascriptreact]": {
                "editor.defaultFormatter": "esbenp.prettier-vscode",
                "editor.formatOnSave": true
            },
            "prettier.requireConfig": true,
            "prettier.useEditorConfig": false,
            "explorer.sortOrder": "type",
            "prettier.tabWidth": 4,
            //"vetur.format.options.tabSize": 4,
            "workbench.tree.indent": 15,
            "[html]": {
                "editor.defaultFormatter": "apility.beautify-blade",
                "editor.formatOnSave": true
            },
            "editor.wordWrapColumn": 120,
            "[css]": {
                "editor.defaultFormatter": "esbenp.prettier-vscode",
                "editor.formatOnSave": true
            },

            "editor.quickSuggestions": {
                "strings": true
            },
            "[jsonc]": {
                "editor.defaultFormatter": "esbenp.prettier-vscode"
            },
            "[json]": {
                "editor.defaultFormatter": "vscode.json-language-features"
            },
            "security.workspace.trust.untrustedFiles": "open",
            "editor.linkedEditing": true,
            "editor.formatOnSave": false,
            // "editor.fontLigatures": false,
            "editor.fontLigatures": "'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'calt', 'dlig'",
            "diffEditor.wordWrap": "on",
            "notebook.output.wordWrap": true,
            "editor.fontSize": 16,
            "editor.minimap.maxColumn": 250,
            "codesnap.containerPadding": "8em",
            "codesnap.boxShadow": "rgba(0, 0, 0, 0.55) 0px 12px 24px",
            "explorer.confirmDelete": false,
            "editor.accessibilitySupport": "off",
            "chat.editor.wordWrap": "on",
            "editor.wordWrap": "wordWrapColumn",
            "[php]": {
                "editor.defaultFormatter": "bmewburn.vscode-intelephense-client"
            },
            "tailwindCSS.includeLanguages": {
                "plaintext": "html"
            },
            "tailwindCSS.experimental.configFile": null,
            "editor.fontWeight": "400",
            "editor.inlineSuggest.suppressSuggestions": true,
            "codesnap.backgroundColor": "#FFC540",
            "codesnap.showLineNumbers": false,
            "codesnap.roundedCorners": true,
            "editor.padding.top": 16,
            "editor.cursorBlinking": "solid",
            "editor.stickyScroll.enabled": false,
            "editor.lineHeight": 32,

            "editor.tokenColorCustomizations": {
                "textMateRules": [
                    {
                    "scope": [
                        "comment",
                        "keyword",
                        "variable.language",
                        "entity.other.attribute-name.html",
                        "entity.other.attribute-name",
                        "keyword.control",
                        "storage.type",
                        "comment",
                        "comment.block",
                        "comment.line"
                    ],
                    "settings": {
                        "fontStyle": ""
                    }
                    }
                ]
            },
            "material-icon-theme.saturation": 0,
            "vscode_custom_css.imports": [
                "file:/home/mirage/.config/Code/User/custom-vscode.css",
                "file:/home/mirage/.config/Code/User/vscode-script.js"
            ],
            "material-icon-theme.files.color": "#42a5f5",
            "workbench.tree.enableStickyScroll": false,
            "workbench.activityBar.location": "hidden"
          }
        '';
      };
    };
  };
}
