{
  services = {
    jitsi-meet = {
      enable = true;
      hostName = "meet.glepage.com";
      caddy.enable = true;
    };

    jitsi-videobridge.openFirewall = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "jitsi-meet-1.0.8043"
  ];
}
