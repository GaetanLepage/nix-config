{
  lib,
  config,
  ...
}:
{
  imports = [
    ./mistral-ssh.nix
  ];

  services.ssh-agent.enable = lib.mkForce false;

  mistral.ssh = {
    enable = true;

    username = "gaetan.lepage";
  };

  programs.ssh.matchBlocks = {
    "github.com".identityFile = "${config.home.homeDirectory}/.ssh/mistral";
  };
}
