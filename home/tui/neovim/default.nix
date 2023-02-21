{pkgs, ...}: {
  imports = [
    ./autocommands.nix
    ./completion.nix
    ./highlights.nix
    ./keymappings.nix
    ./options.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  home = {
    shellAliases.v = "nvim";

    sessionVariables.EDITOR = "nvim";
  };
}
