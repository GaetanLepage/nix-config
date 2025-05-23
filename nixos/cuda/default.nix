{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix

    # ./mistral
    ./ollama.nix

    # ./desktop
    ./disko.nix
    ./harmonia
    ./nfs.nix
    # ./nix-remote-builder.nix
    ./server-tank-nfs.nix
    ./wireguard
  ];

  networking.hostName = "cuda";
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM8hW7fGKCrOavX/WKjhGyyjxo0HBCT265HpsiV68gTR";

  time.hardwareClockInLocalTime = true;

  my-modules = {
    sshClient.enable = true;
    remoteBuilders.enable = true;
    desktop = {
      enable = true;
      nvidia = true;
    };
    dev.enable = true;
  };

  system.stateVersion = "24.05";
}
