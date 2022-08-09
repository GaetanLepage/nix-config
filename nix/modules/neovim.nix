{ pkgs, ... }:

{
    environment.systemPackages = [ pkgs.neovim-nightly ];

    programs.neovim = {
        enable = true;

        package = pkgs.neovim-nightly;

        defaultEditor = true;

        viAlias = true;
        vimAlias = true;

        withNodeJs = true;
        withPython3 = true;
    };
}
