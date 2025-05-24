{
  nixosHosts.cuda = {
    hasHM = true;
    unstable = true;
    deploy.remoteBuild = true;
  };
}
