{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      typst
    ];
  };

  programs.nixvim = {
    files."after/ftplugin/typst.lua".keymaps = [
      {
        mode = "n";
        key = "<leader>m";
        action = ":TypstWatch<cr>";
      }
    ];

    plugins = {
      # EFM
      efmls-configs.setup.typst.formatter = "typstyle";
      lsp.servers.efm.filetypes = ["typst"];
      lsp-format.lspServersToEnable = ["tinymist"];

      lsp.servers.tinymist = {
        enable = true;
        settings.formatterMode = "typstyle";
      };

      typst-vim = {
        enable = true;
        settings = {
          auto_open_quickfix = false;
          pdf_viewer = "zathura";
        };
      };
    };
  };
}
