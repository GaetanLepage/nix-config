{
  programs.nixvim = {
    # Sets the modes in which text in the cursor line can also be concealed.
    options.concealcursor = "n";

    autoCmd = [
      {
        event = "FileType";
        pattern = "norg";
        command = "set conceallevel=2";
      }
    ];

    plugins.neorg = {
      enable = true;

      modules = {
        "core.defaults" = {};

        "core.keybinds".config.hook.__raw = ''
          function(keybinds)
            keybinds.unmap('norg', 'n', '<C-s>')
          end
        '';

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
