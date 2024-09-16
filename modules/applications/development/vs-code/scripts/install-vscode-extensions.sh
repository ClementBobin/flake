#!/bin/bash

# Function to display messages in color
print_message() {
  echo -e "\e[1;32m$1\e[0m"
}

# List of common extensions
extensions=(
  "aerokaido.three-js-snippets"
  "humao.rest-client"
  "abusaidm.html-snippets"
  "alefragnani.project-manager"
  "endormi.2077-theme"
  "pnp.polacode"
  "github.vscode-github-actions"
  "ms-azuretools.vscode-azurestaticwebapps"
  "ms-vscode.azure-account"
  "esbenp.prettier-vscode"
  "dsznajder.es7-react-js-snippets"
  "pranaygp.vscode-css-peek"
  "ms-dotnettools.vscodeintellicode"
  "ms-dotnettools.vscode-dotnet-runtime"
  "marp-team.marp-vscode"
  "ryanluker.vscode-coverage-gutters"
  "github.vscode-pull-request-github"
  "ms-azuretools.vscode-docker"
  "ms-vscode-remote.remote-wsl"
  "anbuselvanrocky.bootstrap5-vscode"
  "yclepticstudios.unity-snippets"
  "aaron-bond.better-comments"
  "wmaurer.change-case"
  "streetsidesoftware.code-spell-checker"
  "k--kato.docomment"
  "fudge.auto-using"
  "revrenlove.c-sharp-utilities"
  "amlovey.shaderlabvscodefree"
  "slevesque.shader"
  "timgjones.hlsltools"
  "fabriciohod.unity-dev-pack"
  "diegosarmentero.unity-dots-snippets"
  "ms-vscode-remote.remote-containers"
  "johnpapa.vscode-peacock"
  "usernamehw.errorlens"
  "formulahendry.auto-rename-tag"
  "orta.vscode-jest"
  "christian-kohler.path-intellisense"
  "visualstudioexptteam.intellicode-api-usage-examples"
  "visualstudioexptteam.vscodeintellicode"
  "ms-vscode.live-server"
  "ms-python.python"
  "ms-python.vscode-pylance"
  "ms-azuretools.vscode-azureresourcegroups"
  "akmarnafi.comment-headers"
  "nicholashsiang.vscode-javascript-comment"
  "vivaxy.vscode-conventional-commits"
  "bradlc.vscode-tailwindcss"
  "firsttris.vscode-jest-runner"
  "yandeu.five-server"
  "pkief.material-icon-theme"
  "alexey-glazov.cool-graphite-and-turquoise"
  "joshbolduc.commitlint"
  "visualstudiotoolsforunity.vstuc"
  "ms-dotnettools.csdevkit"
  "ms-dotnettools.csharp"
  "ms-vsliveshare.vsliveshare"
  "graphite.gti-vscode"
  "blackboxapp.blackbox"
  "GitHub.codespaces"
  "GitHub.copilot"
  "GitHub.copilot-chat"
)

# Check if VS Code or VSCodium is installed
if command -v code >/dev/null; then
  vscode_command="code"
  editor_name="Visual Studio Code"
elif command -v codium >/dev/null; then
  vscode_command="codium"
  editor_name="VSCodium"
else
  print_message "Error: Neither Visual Studio Code nor VSCodium is installed."
  exit 1
fi

# Install extensions
for extension in "${extensions[@]}"; do
  if $vscode_command --list-extensions | grep -q "$extension"; then
    print_message "Extension $extension is already installed for $editor_name."
  else
    $vscode_command --install-extension "$extension"
    print_message "Installed $extension for $editor_name."
  fi
done

print_message "Extensions installed successfully for $editor_name."
