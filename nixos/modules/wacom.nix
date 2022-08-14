{ pkgs, ... }:

{
    services.xserver.wacom.enable = true;

    environment.systemPackages = with pkgs; [
        libwacom
        xf86_input_wacom
    ];
}
