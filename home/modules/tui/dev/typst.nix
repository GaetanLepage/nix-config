{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      typst
    ];
  };

  programs.nixvim = {
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
        settings.pdf_viewer = "zathura";
      };
    };
  };
}
