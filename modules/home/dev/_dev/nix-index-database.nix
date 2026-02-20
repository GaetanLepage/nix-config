{ inputs, ... }:
{
  imports = [
    inputs.nix-index-database.homeModules.nix-index
  ];

  programs = {
    # runs programs without installing them
    nix-index-database.comma.enable = true;
  };
}
