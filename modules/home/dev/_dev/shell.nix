{ pkgs, ... }:
{
  programs = {
    nixvim = {
      extraPackages = with pkgs; [
        shellcheck
        shfmt
      ];
      lsp.servers.bashls.enable = true;
      plugins.lsp-format.settings.sh.exclude = [ "bashls" ];
    };
  };
}
