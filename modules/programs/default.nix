#
#  Apps
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ configuration.nix
#   └─ ./modules
#       └─ ./programs
#           ├─ default.nix *
#           └─ ...
#

[
  ./alacritty.nix
  ./flatpak.nix
  ./wofi.nix
  ./games.nix
  ./tools/filezilla.nix
  ./tools/gitkraken.nix
  ./tools/parsec.nix
  ./environment/csharp.nix
  ./environment/nodejs.nix
  ./environment/python.nix
  ./environment/wine.nix
  ./documentation/obsidian.nix
  #./communication/discord.nix
  ./communication/teams.nix
  ./app/spotify.nix
]
