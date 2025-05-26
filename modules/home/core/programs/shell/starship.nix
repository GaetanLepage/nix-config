{
  flake.modules.homeManager.core = {
    programs.starship = {
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
