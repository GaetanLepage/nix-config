{pkgs, ...}: {
  imports = [
    ./autocommands.nix
    ./completion.nix
    ./keymappings.nix
    ./options.nix
    ./plugins
    ./todo.nix
  ];

  home = {
    shellAliases.v = "nvim";

    sessionVariables.EDITOR = "nvim";
  };

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    # Highlight and remove extra white spaces
    highlight.ExtraWhitespace.bg = "red";
    match.ExtraWhitespace = "\\s\\+$";
  };
}
