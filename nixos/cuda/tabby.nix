{
  users.users.gaetan.extraGroups = ["docker"];
  virtualisation = {
    # podman = {
    #   enable = true;
    #   dockerCompat = true;
    #   enableNvidia = true;
    # };
    docker = {
      enable = true;
      enableNvidia = true;
    };

    # oci-containers.containers.tabby = {
    #   image = "tabbyml/tabby";
    #   ports = ["8080:8080"];
    #   volumes = [
    #     "/var/tabby:/data"
    #   ];
    #
    #   extraOptions = [
    #     "--gpus"
    #     "all"
    #   ];
    #
    #   cmd = [
    #     "serve"
    #     "--model"
    #     "TabbyML/StarCoder-1B"
    #     "--device"
    #     "cuda"
    #   ];
    # };
  };
}
