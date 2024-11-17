{
  imports = [
    ./barbar.nix
    ./comment.nix
    ./floaterm.nix
    ./harpoon.nix
    ./lsp.nix
    ./lualine.nix
    ./markdown-preview.nix
    ./neorg.nix
    ./neo-tree.nix
    ./startify.nix
    ./telescope.nix
    ./treesitter.nix
    ./vimtex.nix # inria
  ];

  programs.nixvim = {
    colorschemes.gruvbox.enable = true;

    plugins = {
      web-devicons.enable = true;

      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };

      nvim-autopairs.enable = true;

      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };

      oil.enable = true;

      trim = {
        enable = true;
        settings = {
          highlight = true;
          ft_blocklist = [
            "checkhealth"
            "floaterm"
            "lspinfo"
            "neo-tree"
            "TelescopePrompt"
          ];
        };
      };
    };
  };
}
