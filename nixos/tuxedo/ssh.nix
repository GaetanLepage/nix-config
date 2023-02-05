{
    # I need to enable the OpenSSH server on my laptop because it is required by agenix
    services.openssh = {
        enable = true;
        openFirewall = false;
    };
}
