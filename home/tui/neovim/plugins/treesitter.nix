{config, ...}: {
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;

      folding = true;
      indent = true;

      grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
        bash
        c
        html
        help # neovim help
        javascript
        latex
        lua
        nix
        norg
        python
        rust
      ];
    };

    treesitter-refactor = {
      enable = true;
      highlightDefinitions.enable = true;
    };
  };
}
