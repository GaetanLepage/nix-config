{
  pkgs,
  lib,
  ...
}:
{
  programs = {
    fish = {
      enable = true;

      interactiveShellInit = ''
        ${lib.getExe pkgs.pfetch}

        # don't greet
        function fish_greeting; end

        # Map '-' to cd back to previous directory
        abbr -a -- - prevd

        # use vi bindings
        set -g fish_key_bindings fish_vi_key_bindings

        # Emulates vim's cursor shape behavior
        set -g fish_vi_force_cursor 1
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
