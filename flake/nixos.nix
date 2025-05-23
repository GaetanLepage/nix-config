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

    vps = {
      unstable = false;
    };

    tank = {
      unstable = false;
    };

    feroe = {
      unstable = false;
    };
  };
}
