{
  imports = [
    ./modules

    ./home-manager.nix
    ./nixos.nix
    ./substituters.nix
    ./treefmt.nix
  ];

  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];
}
