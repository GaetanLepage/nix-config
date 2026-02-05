{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix

    ./disko.nix
    # ./gaming.nix
    # ./gnome-desktop.nix
    # ./nix-remote-builder.nix
    ./ollama.nix
    ./server-tank-nfs.nix
    ./wireguard
  ];

  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM8hW7fGKCrOavX/WKjhGyyjxo0HBCT265HpsiV68gTR";

  time.hardwareClockInLocalTime = true;

  system.stateVersion = "24.05";
}
