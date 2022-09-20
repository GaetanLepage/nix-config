{
    programs.steam = {
        enable = true;

        # Open ports in the firewall for Steam Remote Play
        remotePlay.openFirewall = true;

        # Open ports in the firewall for Source Dedicated Server
        dedicatedServer.openFirewall = true;
    };
}
