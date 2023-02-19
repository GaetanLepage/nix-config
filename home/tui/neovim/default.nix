{pkgs, ...}: {
  xdg.configFile.nvim.source = ./nvim;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      nodePackages.neovim
      nodejs
      tree-sitter
      yarn # Needed to install Markdown-preview plugin

      # Language servers
      nodePackages.bash-language-server # Bash language server
      nodePackages.typescript # TypeScript
      nodePackages.typescript-language-server # TypeScript language server
      lua-language-server # Lua language server
      clang-tools # C/C++ language server
      texlab # LaTeX language server
      xdotool # For forward search in zathura
      pstree # For inverse search in vimtex
      rnix-lsp # Nix language server
      rust-analyzer # Rust language server
    ];
  };

  home = {
    shellAliases.v = "nvim";

    sessionVariables.EDITOR = "nvim";

    packages = with pkgs; [
      ctags
      gcc # Needed to compile some of the tree-sitter parsers.
    ];
  };
}
