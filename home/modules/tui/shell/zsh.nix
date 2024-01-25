{
  config,
  pkgs,
  ...
}: {
  xdg.configFile.zsh_vim_bindings = {
    source = ./zsh_vim_bindings;
    target = "zsh/zsh_vim_bindings";
  };

  home.packages = with pkgs; [
    pfetch
  ];

  programs = {
    zsh = {
      enable = true;

      dotDir = ".config/zsh";

      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;

      history = {
        path = "${config.xdg.stateHome}/zsh_history";
        size = 50000;
      };

      oh-my-zsh = {
        enable = true;
        plugins = ["git"];
      };

      initExtra = ''
        pfetch

        # Vim keybindings
        source ${config.home.homeDirectory}/${config.xdg.configFile.zsh_vim_bindings.target}
      '';
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
