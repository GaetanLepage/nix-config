{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Utils
    dua
    file
    git
    killall
    ncdu
    nfs-utils # Linux user-space NFS utilities
    tmux
    tree
    unzip
    wget
    zip

    # Network
    dig # Domain name server
    lsof

    # System monitor
    btop
    htop
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}
