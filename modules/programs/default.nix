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
  #./games.nix
  ./tools/default.nix
  ./environment/default.nix
  ./documentation/default.nix
  ./communication/default.nix
  ./app/default.nix
]
