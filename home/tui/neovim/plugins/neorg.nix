{pkgs, ...}: {
  programs.nixvim = {
    options = {
      conceallevel = 2;
      concealcursor = "nc";
    };

    plugins.neorg = {
      enable = true;

      modules = {
        "core.defaults" = {};

        "core.keybinds".config.hook = {
          __raw = ''
            function(keybinds)
              keybinds.unmap('norg', 'n', '<C-s>')
            end
          '';
        };

        "core.norg.dirman".config.workspaces = {
          notes = "~/notes";
          nix = "~/perso/nix/notes";
        };

        "core.norg.concealer" = {};
        "core.norg.completion".config.engine = "nvim-cmp";
      };
    };
  };
}
