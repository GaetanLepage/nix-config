{ lib, ... }:
{
  programs.nixvim = {
    diagnostic.settings.virtual_text = true;

    lsp = {
      inlayHints.enable = true;
      servers = {
        clangd.enable = true;
        texlab.enable = true; # inria
        lua_ls = {
          enable = true;
          settings.settings.diagnostics.globals = [ "vim" ];
        };
      };

      keymaps =
        lib.mapAttrsToList
          (
            key: props:
            {
              inherit key;
              options.silent = true;
            }
            // props
          )
          {
            "<leader>k".action.__raw = "function() vim.diagnostic.jump({ count=-1, float=true }) end";
            "<leader>j".action.__raw = "function() vim.diagnostic.jump({ count=1, float=true }) end";
            gd.lspBufAction = "definition";
            gD.lspBufAction = "references";
            gt.lspBufAction = "type_definition";
            gi.lspBufAction = "implementation";
            K.lspBufAction = "hover";
            "<F2>".lspBufAction = "rename";
          };
    };

    plugins = {
      lsp-format = {
        enable = true;
        lspServersToEnable = "all";
      };

      # Sane defaults for all servers
      lspconfig.enable = true;
    };
  };
}
