{
  users.users.gaetan.extraGroups = ["docker"];
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
    containers.cdi.dynamic.nvidia.enable = true;

    oci-containers.containers.tabby = {
      image = "tabbyml/tabby";
      ports = ["8080:8080"];
      volumes = [
        "/var/tabby:/data"
      ];

      # Disable telemetry
      environment.TABBY_DISABLE_USAGE_COLLECTION = "1";

      extraOptions = [
        "--device"
        "nvidia.com/gpu=all"
        "--security-opt=label=disable"
      ];

      cmd = [
        "serve"
        "--model"
        "TabbyML/DeepseekCoder-6.7B"
        "--device"
        "cuda"
      ];
    };
  };
}
