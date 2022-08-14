{ ... }:

{
    imports = [
        ./git.nix
        ./lf.nix
        ./neovim
        ./python.nix
        ./remi.nix
        ./shell
        ./ssh.nix
        ./tmux.nix
        ./xdg.nix
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
        bat
        btop
        ripgrep

        git
        git-crypt

        pandoc
    ];

    ###########
    # Scripts #
    ###########
    xdg.configFile.scripts.source = ../scripts;
    # Add the scripts directory to PATH
    # install_dotfiles.sh script
    home.sessionPath = [
        "${config.home.homeDirectory}/${config.xdg.configFile.scripts.target}"
    ];


}
