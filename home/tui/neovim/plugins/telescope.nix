{ config, ... }:
{
    programs.nixvim = {

        maps.normal = let
            mkRaw = config.nixvim.helpers.mkRaw;
        in
        {
            # Find files using Telescope command-line sugar.
            "<leader>ff" = "telescope.builtin.find_files";
            "<leader>fg" = "telescope.builtin.live_grep";
            "<leader>fb" = "telescope.builtin.buffers";
            "<leader>fh" = "telescope.builtin.help_tags";
            # TODO
            # "<leader>fd" =
            #      function()
            #         builtin.diagnostics({bufnr = 0})
            #      end
            # )

            # FZF like bindings
            "<C-p>"     = "<cmd> lua require('telescope.builtin').git_files()<cr>";
            "<leader>p" = "<cmd> lua require('telescope.builtin').oldfiles()<cr>";
            "<C-f>"     = "<cmd> lua require('telescope.builtin').live_grep()<cr>";
        };

        plugins.telescope = {
            enable = true;

            defaults = {
                file_ignore_patterns = [
                    "^.git/"
                    "^.mypy_cache/"
                    "^__pycache__/"
                    "^output/"
                    "^data/"
                    "%.ipynb"
                ];
                set_env.COLORTERM = "truecolor";
            };
        };
    };
}
