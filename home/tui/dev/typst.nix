{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      typst
      typst-fmt
    ];
  };

  programs.nixvim = {

    # TODO remove when neovim 0.10 is out as this should be the defaut behavior
    filetype.extension."typ" = "typst";

    plugins.lsp.servers = {
      typst-lsp = {
        enable = true;
        rootDir = ''
          require 'lspconfig.util'.root_pattern('.git', 'main.typ')
        '';
      };
    };
  };
}
