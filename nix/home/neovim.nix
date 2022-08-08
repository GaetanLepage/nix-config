{ pkgs, ... }:

{
    home.packages = with pkgs; [

        # neovim
        nodePackages.neovim
        nodejs
        tree-sitter
        yarn                        # Needed to install Markdown-preview plugin

        # Language servers
        nodePackages.bash-language-server           # Bash language server
        nodePackages.typescript                     # TypeScript
        nodePackages.typescript-language-server     # TypeScript language server
        sumneko-lua-language-server                 # Lua language server
        clang-tools                                 # C/C++ language server
        texlab                                      # LaTeX language server
        xdotool                                     # For forward search in zathura
        pstree                                      # For inverse search in vimtex
        rnix-lsp                                    # Nix language server
    ];
}
