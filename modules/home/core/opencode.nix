{
  flake.modules.homeManager.core = {
    programs.opencode = {
      enable = true;

      settings = {
        model = "openai/gpt-5.3-codex";
      };
    };

    home.shellAliases.oc = "opencode";
  };
}
