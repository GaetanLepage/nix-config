{
  config,
  lib,
  ...
}: {
  options = {
    githubTokenFile = lib.mkOption {
      type = lib.types.str;
      default = "/run/agenix/github-token";
    };
  };

  config = {
    home.sessionVariables = let
      token = "$(cat ${config.githubTokenFile})";
    in {
      GITHUB_API_TOKEN = token;
      GITHUB_TOKEN = token;
    };
  };
}
