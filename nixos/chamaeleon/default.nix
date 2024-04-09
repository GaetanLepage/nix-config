{
  imports = [
    ./hardware.nix

    ../common

    ./disko.nix
  ];

  system.stateVersion = "24.05"; # Did you read the comment?

  networking.hostName = "chamaeleon";
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIkCMDmzVqqHUv7ClNSAaVTNFzy5ZBrHuDoKymQN85ye";
}
