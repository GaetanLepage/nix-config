{pkgs, ...}: {
  programs = {
    nixvim = {
      extraPackages = with pkgs; [
        shellcheck
        shfmt
      ];
      plugins = {
        lsp.servers.bashls.enable = true;
        lsp-format.lspServersToEnable = ["bashls"];
      };
    };
  };
}
