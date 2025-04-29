{
  nixosHosts = {
    cuda = {
      hasHM = true;
      deploy.remoteBuild = true;
    };
    framework.hasHM = true;
  };
}
