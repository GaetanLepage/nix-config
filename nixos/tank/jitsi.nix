{
  services = {
    jitsi-meet = {
      enable = true;
      hostName = "meet.glepage.com";
      caddy.enable = true;
    };

    jitsi-videobridge.openFirewall = true;
  };
}
