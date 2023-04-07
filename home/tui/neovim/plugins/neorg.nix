{
  programs.nixvim = {
    # Sets the modes in which text in the cursor line can also be concealed.
    options.concealcursor = "n";

    autoCmd = [
      {
        event = "FileType";
        pattern = "norg";
        command = "setlocal conceallevel=2";
      }
      {
        event = "BufWritePre";
        pattern = "*.norg";
        command = "normal gg=G``zz";
      }
    ];

    plugins.neorg = {
      enable = true;

      modules = {
        "core.defaults".__empty = null;

        "core.keybinds".config.hook.__raw = ''
          function(keybinds)
            keybinds.unmap('norg', 'n', '<C-s>')
          end
        '';

        "core.norg.dirman".config.workspaces = {
          notes = "~/notes";
          nix = "~/perso/nix/notes";
        };

        "core.norg.concealer".__empty = null;
        "core.norg.completion".config.engine = "nvim-cmp";
      };
    };
  };
}
