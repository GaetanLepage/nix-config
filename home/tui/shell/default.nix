{ config, ... }:
{
  imports = [
    ./exa.nix
    ./exputils.nix
    ./remi.nix
    ./zsh.nix
  ];

  home = {
    shellAliases = import ./aliases.nix;

    sessionVariables = {
      XCOMPOSECACHE="${config.xdg.cacheHome}/X11/xcompose";
    };
  };

  programs = {
    autojump.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    fzf.enable = true;
  };
}
