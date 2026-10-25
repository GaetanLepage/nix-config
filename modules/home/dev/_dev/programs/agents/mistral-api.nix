{ config, lib, ... }: {
  options.exportMistralApiKey = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };

  config = lib.mkIf config.exportMistralApiKey {
    age.secrets.mistral-api-key.rekeyFile = ./mistral-api-key.age;

    home.sessionVariables = {
      MISTRAL_API_KEY = "$(cat ${config.age.secrets.mistral-api-key.path})";
    };
  };
}
