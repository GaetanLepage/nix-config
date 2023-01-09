{ config, ... }:
{
    programs.nixvim.plugins = {
        treesitter = {
            enable = true;

            folding = true;
            indent = true;

            # nixGrammars = false;
            # parserInstallDir = "${config.xdg.dataHome}/nvim/treesitter";
            # ensureInstalled = [
            #     "bash"
            #     "c"
            #     "html"
            #     "help"         # neovim help
            #     "javascript"
            #     "latex"
            #     "lua"
            #     "nix"
            #     "norg"
            #     "python"
            #     "rust"
            # ];
        };

        treesitter-refactor = {
            enable = true;
            highlightDefinitions.enable = true;
        };
    };
}
