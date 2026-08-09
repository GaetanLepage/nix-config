{
  imports = [
    ./wireguard

    ./disko.nix
    ./hardware.nix
    ./networking.nix
    ./nix-remote-builder.nix
    ./spark.nix
  ];

  age.rekey.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN2Q4+N0omMprcAElB7JtvKiqw+sUDkJwkdawhXVtVwm";

  system.stateVersion = "26.11";
}
