{
  programs.nixvim = {
    plugins = {
      lsp-format.lspServersToEnable = ["lua_ls"];
      lsp.servers.lua_ls = {
        enable = true;
        settings.diagnostics.globals = ["vim"];
      };
    };
  };
}
