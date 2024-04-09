{
  config,
  lib,
  ...
}: {
  options.githubToken = {
    enable = lib.mkEnableOption "github token" // {default = true;};
  };
  config =
    lib.mkIf config.githubToken.enable
    {
      home.sessionVariables = let
        token = "$(cat /run/agenix/github-token)";
      in {
        GITHUB_API_TOKEN = token;
        GITHUB_TOKEN = token;
      };
    };
}
