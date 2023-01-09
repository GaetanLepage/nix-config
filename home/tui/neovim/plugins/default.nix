{
    imports = [
        ./barbar.nix
        ./comment.nix
        # ./harpoon.nix
        ./lsp.nix
        ./lualine.nix
        ./neorg.nix
        ./nvim-tree.nix
        ./startify.nix
        ./tagbar.nix
        ./telescope.nix
        ./treesitter.nix
        # ./vimtex.nix
    ];

    programs.nixvim = {

        colorschemes.gruvbox.enable = true;

        plugins = {

            gitsigns = {
                enable = true;
                signs = {
                    add.text = "+";
                    change.text = "~";
                };
            };

            # markdown-preview = {
            #     enable = true;
            #
            #     autoStart = true;
            #     autoClose = false;
            #
            #     theme = "dark";
            # };

            nvim-autopairs.enable = true;

            nvim-colorizer.enable = true;
        };
    };
}
