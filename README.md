# ❄️ My NixOS Configuration

This repository holds the configuration for all my Linux systems.
It includes both my servers, my laptop and my desktop.


## Nix

I now manage all my configuration thanks to Nix:

- [NixOS](https://nixos.org/) on the system side: `nixos/`
- [home-manager](https://github.com/nix-community/home-manager) for the user-specific configuration:
    `home/`

Everything is managed thanks to a [nix flake](https://nixos.wiki/wiki/Flakes): `flake.nix`.

## Systems

| Hostname      | NixOS?    | Comment                           |
| :------------ | :-------- | :-------------------------------- |
| `framework`   | Yes       | Laptop                            |
| `cuda`        | Yes       | Personal workstation              |
| `alya`        | No        | Pro workstation                   |
| `vps`         | Yes       | VPS (VPN, mail server, etc.)      |
| `tank`        | Yes       | NAS (ZFS, Nextcloud, etc.)        |
| `feroe`       | Yes       | Backup (replication of `tank`)    |

### Linux working environment

![](./.assets/screenshot.png)

Here are the programs I use on my working systems.
I keep my configuration minimal and efficient.

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
