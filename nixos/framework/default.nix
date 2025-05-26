{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix

    ./autofs.nix
    ./disko.nix
    ./wireguard
  ];
}
