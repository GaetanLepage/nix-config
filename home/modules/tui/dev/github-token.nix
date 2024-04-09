{
  home.sessionVariables = let
    token = "$(cat /run/agenix/github-token)";
  in {
    GITHUB_API_TOKEN = token;
    GITHUB_TOKEN = token;
  };
}
