{
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix

    ../_modules

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

  environment.systemPackages = with pkgs; [
    # Utils
    git
    ncdu
    tmux
    unzip
    vim

    # System monitor
    btop
    htop
  ];

  my-modules = {
    remote-builders.enable = true;
    desktop = {
      enable = true;
      nvidia = true;
    };
  };

  system = {
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "24.05"; # Did you read the comment?
  };
}
