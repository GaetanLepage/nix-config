{pkgs, ...}: {
  #     extraPackages = with pkgs; [
  #
  #         nodePackages.neovim
  #         nodejs
  #         tree-sitter
  #         yarn                        # Needed to install Markdown-preview plugin
  #
  #         # Language servers
  #         nodePackages.bash-language-server           # Bash language server
  #         sumneko-lua-language-server                 # Lua language server
  #         clang-tools                                 # C/C++ language server
  #         texlab                                      # LaTeX language server

  #         xdotool                                     # For forward search in zathura
  #         pstree                                      # For inverse search in vimtex
  #         rnix-lsp                                    # Nix language server
  #         rust-analyzer                               # Rust language server
  #     ];
  # };

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
