{
  flake.modules.homeManager.core = {
    programs.opencode = {
      enable = true;

      settings = {
        model = "openai/gpt-5.2-codex";
      };
    };

    home.shellAliases.oc = "opencode";
  };
}
