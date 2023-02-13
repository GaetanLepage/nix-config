{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        virtualbox
    ];

    services.xserver.wacom.enable = true;
    virtualisation.virtualbox.host.enable = true;

    users.extraGroups.vboxusers.members = [ "gaetan" ];
}
