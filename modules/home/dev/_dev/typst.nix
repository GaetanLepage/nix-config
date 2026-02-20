{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      typst
      typstyle
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

    lsp.servers.tinymist = {
      enable = true;
      config.settings = {
        formatterMode = "typstyle";
        projectResolution = "lockDatabase";
        exportPdf = "onType";
      };
    };

    plugins = {
      typst-preview = {
        enable = true;

        settings = {
          dependencies_bin.tinymist = "tinymist";
        };
      };

      typst-vim = {
        enable = true;
        settings = {
          auto_open_quickfix = false;
          pdf_viewer = "zathura";
          typst_syntax_highlight = false;
        };
      };
    };
  };
}
