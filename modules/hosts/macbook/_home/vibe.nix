{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    mistral-vibe # TODO: remove
    google-cloud-sdk
  ];
  # programs.mistral-vibe = {};

  home.sessionVariables = {
    # Claude code
    CLAUDE_CODE_USE_VERTEX = 1;
    CLOUD_ML_REGION = "global";
    ANTHROPIC_VERTEX_PROJECT_ID = "code-model-vertex";
    ANTHROPIC_MODEL = "claude-opus-4-6";
    ANTHROPIC_SMALL_FAST_MODEL = "claude-haiku-4-6";

    # OpenCode
    GOOGLE_APPLICATION_CREDENTIALS = "${config.xdg.configHome}/gcloud/application_default_credentials.json";
    GOOGLE_CLOUD_PROJECT = "code-model-vertex";
    VERTEX_LOCATION = "global";

    # TODO: move to agenix
    MISTRAL_API_KEY = "$(cat ${config.xdg.dataHome}/mistral_api_key)";
  };
}
