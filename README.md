# ❄️ My NixOS Configuration

This is my personal repository for configuration files of all the programs I
use on a daily basis.
This setup aims to be minimal while being pleasing to the eye and functional.

![](./.assets/screenshot.png)

## Nix

I now manage all my configuration thanks to Nix:

- [NixOS](https://nixos.org/) on the system side: `nixos/`
- [home-manager](https://github.com/nix-community/home-manager) for the user-specific configuration:
    `home/`

Everything is managed thanks to a [nix flake](https://nixos.wiki/wiki/Flakes): `flake.nix`.


## Software

| Program               | Name                                                  |
| :-------------------- | :-----------------------------------------------------|
| Linux Distribution    | [NixOS](https://nixos.org/)                           |
| Web Browser           | [Firefox](https://www.mozilla.org/en-US/firefox/new/) |
| Window Manager        | [sway](https://swaywm.org/)                           |
| Bar                   | [waybar](https://github.com/Alexays/Waybar)           |
| Terminal Emulator     | [foot](https://codeberg.org/dnkl/foot)                |
| Code Editor           | [Neovim](https://neovim.io/)                          |
| Program Launcher      | [rofi](https://github.com/DaveDavenport/rofi)         |
| Shell                 | [fish](https://fishshell.com/)                        |
| PDF viewer            | [Zathura](https://pwmt.org/projects/zathura/)         |
