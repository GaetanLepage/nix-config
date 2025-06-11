{
  flake.modules.nixos.core =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Utils
        dua
        fd
        file
        git
        killall
        ncdu
        nfs-utils # Linux user-space NFS utilities
        ripgrep
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

        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
      };
    };
}
