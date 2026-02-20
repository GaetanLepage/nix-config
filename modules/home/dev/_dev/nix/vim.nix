{ lib, pkgs, ... }:
{
  programs.nixvim = {
    lsp.servers.nil_ls = {
      enable = true;
      config.settings.formatting.command = [
        (lib.getExe pkgs.nixfmt)
      ];
    };

    files."after/ftplugin/nix.lua" = {
      # Set indentation to 2 spaces
      localOpts = {
        tabstop = 2;
        shiftwidth = 2;
      };
    };
  };
}
