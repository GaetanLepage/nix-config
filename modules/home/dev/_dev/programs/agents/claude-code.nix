{
  programs.claude-code = {
    enable = true;

    enableMcpIntegration = true;

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
