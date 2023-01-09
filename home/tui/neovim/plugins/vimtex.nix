{pkgs, ...}: {
  programs.nixvim = {
    plugins.vimtex = {
      enable = true;

      extraConfig = {
        view_method = "zathura";

        quickfix_enabled = true;
        quickfix_open_on_warning = false;

        # Ignore undesired errors and warnings
        quickfix_ignore_filters = [
          "Underfull"
          "Overfull"
          "specifier changed to"
          "Token not allowed in a PDF string"
        ];

        # TOC settings
        toc_config = {
          name = "TOC";
          layers = ["content" "todo"];
          resize = true;
          split_width = 50;
          todo_sorted = false;
          show_help = true;
          show_numbers = true;
          mode = 2;
        };
      };
    };
  };
}
