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

  # Allows deploying the Spark (aarch64-linux) config from this x86_64 system
  # https://bhankas.org/blog/deploying_nixos_to_raspberry_pi_from_lapop
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
