{ inputs, ... }:
{
  flake.modules.homeManager.core = {
    imports = [
      inputs.nixvim.homeModules.nixvim
      ./_plugins
    ];

    home.shellAliases.v = "nvim";

    programs.nixvim = {
      enable = true;
      defaultEditor = true;

      nixpkgs.useGlobalPackages = true;

      viAlias = true;
      vimAlias = true;
    };
  };
}
