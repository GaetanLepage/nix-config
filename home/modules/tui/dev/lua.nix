{
  programs.nixvim = {
    plugins = {
      lsp-format.lspServersToEnable = ["lua-ls"];
      lsp.servers.lua-ls = {
        enable = true;
        settings.diagnostics.globals = ["vim"];
      };
    };
  };
}
