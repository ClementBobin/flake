#
#  Virtualisation Modules
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./<host>
#   │       └─ default.nix
#   └─ ./modules
#       └─ ./desktop
#           └─ ./virtualisation
#               ├─ default.nix *
#               └─ ...
#

[
  ./docker.nix
  ./virtualbox.nix
]
