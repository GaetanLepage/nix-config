{
  imports = [
    ./agenix.nix
    ./devshell.nix
    ./home-manager.nix
    ./nixos.nix
  ];

  perSystem = {pkgs, ...}: {
    formatter = pkgs.alejandra;
  };
}
