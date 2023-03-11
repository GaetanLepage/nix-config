{
  programs.nixvim = {
    highlight.Todo = {
      fg = "Blue";
      bg = "Yellow";
    };

    match.TODO = "TODO";

    maps.normal."<C-t>" = {
      action = ''
        function()
          require('telescope.builtin').live_grep({
            default_text="TODO",
            initial_mode="normal"
          })
        end
      '';
      lua = true;
      silent = true;
    };
  };
}
