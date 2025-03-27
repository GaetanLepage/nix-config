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

    # Terminal
    terminal = {
      inherit font_family font_size;
    };

    # Editor
    show_whitespaces = "none";
    vim_mode = true;
    theme = "Ayu Dark";

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
