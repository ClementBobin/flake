#
#  Environment
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ configuration.nix
#   └─ ./modules
#       └─ ./programs
#           └─ ./environment
#               ├─ default.nix
#               └─ ...
#

[
    ./csharp.nix
    ./nodejs.nix
    ./python.nix
    ./wine.nix
]
