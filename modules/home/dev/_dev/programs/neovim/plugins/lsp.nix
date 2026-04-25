{ lib, pkgs, ... }:
{
  programs.nixvim = {
    diagnostic.settings.virtual_text = true;

    lsp = {
      inlayHints.enable = true;
      servers = {
        clangd.enable = true;
        lua_ls = {
          enable = true;
          config.settings.diagnostics.globals = [ "vim" ];
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
            "<leader>f".lspBufAction = "format";
          };
    };

    plugins = {
      lsp-format = {
        enable = true;
        package = pkgs.vimPlugins.lsp-format-nvim.overrideAttrs (old: {
          src = pkgs.fetchFromGitHub {
            owner = "GaetanLepage";
            repo = "lsp-format-nvim";
            rev = "new-api";
            hash = "sha256-OoubWk1om8we3MWA73PCGkax0nbOc+NxJ6pLq9KRfVE=";
          };
        });
        lspServersToEnable = "all";
      };

      # Sane defaults for all servers
      lspconfig.enable = true;
    };
  };
}
