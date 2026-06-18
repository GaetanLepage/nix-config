{ lib, pkgs, ... }:
{
  programs.nixvim = {
    lsp.servers.nil_ls = {
      enable = true;

      config.settings.nil = {
        formatting.command = [
          (lib.getExe pkgs.nixfmt)
        ];

        # Don't try to archive the flake inputs
        nix.flake.autoArchive = false;
      };
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
