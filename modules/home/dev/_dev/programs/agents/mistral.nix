{ config, ... }:
{
  age.secrets.mistral-api-key.rekeyFile = ./mistral-api-key.age;

  home.sessionVariables = {
    MISTRAL_API_KEY = "$(cat ${config.age.secrets.mistral-api-key.path} 2>/dev/null || true)";
  };
}
