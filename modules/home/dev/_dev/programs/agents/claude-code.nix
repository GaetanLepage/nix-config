{ config, ... }:
{
  programs.claude-code = {
    enable = true;

    enableMcpIntegration = true;

    # Default starting in newer home-manager versions
    configDir = "${config.xdg.configHome}/claude";

    settings = {
      # flicker-free mode
      tui = "fullscreen";

      permissions = {
        allow = [
          "Bash(grep:*)"
          "Bash(rg:*)"
          "Bash(git log:*)"
          "Bash(git status:*)"
          "Bash(git diff:*)"
          "Bash(ls:*)"
          "Bash(find:*)"
        ];
      };
    };
  };
}
