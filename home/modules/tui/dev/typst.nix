{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      typst
    ];
  };

  programs.nixvim = {
    plugins = {
      # EFM
      efmls-configs.setup.typst.formatter = "typstyle";
      lsp.servers.efm.filetypes = ["typst"];

      lsp.servers.tinymist = {
        enable = true;
        settings.formatterMode = "typstyle";
      };

      typst-vim = {
        enable = true;
        settings.pdf_viewer = "zathura";
      };
    };
  };
}
