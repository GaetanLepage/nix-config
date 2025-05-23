{
  nixosHosts = {
    cuda = {
      hasHM = true;
      unstable = true;
      deploy.remoteBuild = true;
    };
    framework = {
      hasHM = true;
      unstable = true;
    };

    tank = {
      unstable = false;
    };
  };
}
