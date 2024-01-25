{pkgs, ...}: {
  programs = {
    fish = {
      enable = true;

      shellInit = ''
        ${pkgs.pfetch}/bin/pfetch

        # don't greet
        function fish_greeting; end

        # use vi bindings
        fish_vi_key_bindings
        bind l accept-autosuggestion

        # Emulates vim's cursor shape behavior
        # Set the normal and visual mode cursors to a block
        set fish_cursor_default block
        # Set the insert mode cursor to a line
        set fish_cursor_insert line
        # Set the replace mode cursors to an underscore
        set fish_cursor_replace_one underscore
        set fish_cursor_replace underscore

        function multicd
          echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
        end
        abbr --add dotdot --regex '^\.\.+$' --function multicd
      '';

      plugins = [
        {
          name = "plugin-git";
          src = pkgs.fishPlugins.plugin-git.src;
        }
        {
          name = "bass";
          src = pkgs.fishPlugins.bass.src;
        }
      ];
    };

    # Prompt theme
    starship = {
      enable = true;

      settings = {
        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[✗](bold red)";
        };

        python = {
          format = "[$symbol $pyenv_prefix($version )(\\($virtualenv\\))]($style) ";
          symbol = "";
          version_format = "$raw";
          style = "bold yellow";
        };

        nix_shell = {
          format = "[$symbol$state]($style) ";
          symbol = "❄️";
        };
      };
    };
  };
}
