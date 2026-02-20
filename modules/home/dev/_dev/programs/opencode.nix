{ lib, ... }:
{
  programs.opencode = {
    enable = true;

    settings = {
      model = lib.mkDefault "openai/gpt-5.3-codex";
    };
  };

  home.shellAliases.oc = "opencode";
}
