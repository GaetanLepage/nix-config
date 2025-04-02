{ lib, pkgs, ... }:
let
  font_family = "DejaVu Sans Mono";
  font_size = 20;
in
{
  programs.zed-editor.userSettings = {
    # Misc
    auto_update = false;
    assistant.enabled = false;
    telemetry = {
      diagnostics = true;
      metrics = true;
    };
    load_direnv = "shell_hook";
    ssh_connections = import ./ssh-connections.nix;

    # UI
    hour_format = "hour24";
    ui_font_family = font_family;
    ui_font_size = font_size;
    project_panel = {
      hide_gitignore = true;
    };

    # Terminal
    terminal = {
      inherit font_family font_size;
      line_height = "standard";
    };

    # Editor
    theme = "Ayu Dark";
    vim_mode = true;
    relative_line_numbers = true;
    show_whitespaces = "none";
    scroll_beyond_last_line = "off";
    git = {
      inline_blame.enabled = false;
    };

    buffer_font_family = font_family;
    buffer_font_size = font_size;

    format_on_save = "on";

    # Languages
    lsp = {
      # rust-analyzer.binary.path_lookup = true;
      # ruff.binary.path_lookup = true;
      # pylsp.binary.path_lookup = true;
      nil.settings = {
        formatting.command = [ (lib.getExe pkgs.nixfmt-rfc-style) ];
      };
    };
    languages = {
      Python = {
        language_servers = [
          "pylsp"
          "ruff"
        ];
      };
      Nix = {
        language_servers = [ "nil" ];
      };
    };
  };
}
