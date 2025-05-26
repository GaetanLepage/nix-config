{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix

    ./sound.nix
    ./wireguard
  ];
}
