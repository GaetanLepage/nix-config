{
  nixosHosts = {
    cuda = {
      hasHM = true;
      unstable = true;
      deploy.remoteBuild = true;
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
