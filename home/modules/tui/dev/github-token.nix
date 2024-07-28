{
  config,
  lib,
  osConfig,
  ...
}: {
  options.githubToken = {
    enable = lib.mkEnableOption "github token" // {default = true;};
  };
  config =
    lib.mkIf config.githubToken.enable
    {
      home.sessionVariables = let
        token = "$(cat ${osConfig.age.secrets.github-token.path})";
      in {
        GITHUB_API_TOKEN = token;
        GITHUB_TOKEN = token;
      };
    };
}
