{
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixvim.homeModules.nixvim

    ./plugins
    ./autocommands.nix
    ./completion.nix
    ./keymappings.nix
    ./options.nix
    ./performance.nix
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim =
    assert lib.versionOlder config.programs.neovim.package.version "0.12";
    {
      enable = true;
      defaultEditor = true;

      nixpkgs.useGlobalPackages = true;

      viAlias = true;
      vimAlias = true;
    };
}
