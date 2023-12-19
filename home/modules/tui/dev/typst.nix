{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      typst
    ];
  };

  programs.nixvim = {
    # TODO remove when neovim 0.10 is out as this should be the defaut behavior
    filetype.extension.typ = "typst";

    plugins = {
      # EFM
      efmls-configs.setup.typst.formatter = "typstfmt";
      lsp.servers.efm.filetypes = ["typst"];

      lsp.servers.typst-lsp = {
        enable = true;
        rootDir = ''
          require 'lspconfig.util'.root_pattern('.git', 'main.typ')
        '';
        # Conflicts with typst.vim
        extraOptions.settings.exportPdf = "never";
      };

      typst-vim = {
        enable = true;
        pdfViewer = "zathura";
      };
    };
  };
}
