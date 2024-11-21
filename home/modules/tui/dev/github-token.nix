{
  lib,
  osConfig,
  ...
}: {
  home.sessionVariables =
    lib.optionalAttrs
    # Only enable if using NixOS + agenix
    (osConfig ? age.secrets.github-token)
    (
      let
        token = "$(cat ${osConfig.age.secrets.github-token.path})";
      in {
        GITHUB_API_TOKEN = token;
        GITHUB_TOKEN = token;
      }
    );
}
