{
  flake.modules.homeManager.core =
    { lib, pkgs, ... }:
    {
      programs.nixvim = {
        plugins.lsp.servers.nil_ls = {
          enable = true;
          settings.formatting.command = [
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
    };
}
