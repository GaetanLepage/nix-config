{ pkgs, ... }:
{
  programs = {
    bat.enable = true;
    fd.enable = true;
    jq.enable = true;
    ripgrep.enable = true;
  };

  home = {
    packages = with pkgs; [
      # Rust implementations of linux commands
      dust # du
      dua # du
      dysk # df
      procs # ps

      # Other utils
      mprocs
      ncdu
      nixos-anywhere
      tlrc
      wget

      # Network
      dig
    ];
  };
}
