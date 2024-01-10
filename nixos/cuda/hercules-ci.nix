{config, ...}: {
  age.secrets = {
    hercules-ci-binary-caches = {
      file = ../../secrets/hercules-ci/binary-caches.age;
      owner = "hercules-ci-agent";
    };
    hercules-ci-cluster-join-token = {
      file = ../../secrets/hercules-ci/cluster-join-token.age;
      owner = "hercules-ci-agent";
    };
  };

  services.hercules-ci-agent = {
    enable = true;

    settings = {
      binaryCachesPath = config.age.secrets.hercules-ci-binary-caches.path;
      clusterJoinTokenPath = config.age.secrets.hercules-ci-cluster-join-token.path;

      remotePlatformsWithSameFeatures = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    };
  };
}
