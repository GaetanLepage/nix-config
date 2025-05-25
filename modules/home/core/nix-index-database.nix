{ inputs, ... }:
{
  flake.modules.homeManager.nix-index-database = {
    imports = [
      inputs.nix-index-database.hmModules.nix-index
    ];

    # runs programs without installing them
    programs = {
      nix-index-database.comma.enable = true;
    };
  };
}
