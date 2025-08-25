{
  services = {
    ollama = {
      enable = true;
      openFirewall = true;
      host = "10.10.10.4";
      acceleration = "cuda";
      loadModels = [ "llama3.2" ];
    };
  };
}
