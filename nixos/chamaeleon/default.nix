{lib, ...}: {
  imports = [
    ./hardware.nix

    ../common

    ./disko.nix
    ./remote-builders
    ./wireguard
    ./robotlearn
  ];

  system.stateVersion = "24.05"; # Did you read the comment?

  networking.hostName = "chamaeleon";
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIkCMDmzVqqHUv7ClNSAaVTNFzy5ZBrHuDoKymQN85ye";

  nix.gc.options = lib.mkForce "--delete-older-than 14d";
}
