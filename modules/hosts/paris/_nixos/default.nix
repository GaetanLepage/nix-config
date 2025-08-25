{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix

    ./disko.nix
  ];

  networking.hostName = "paris";
  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIInEvK+lzeXDPffCUytCvqD97kEiooV9bNdfeecGm2Rr";

  system.stateVersion = "25.05";
}
