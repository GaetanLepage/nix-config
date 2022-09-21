{
    services.picom = {
        enable = true;

        backend = "glx";
        experimentalBackends = true;

        settings = {
            blur = {
                method = "gaussian";
                size = 10;
                deviation = 10.0;
            };
        };
    };
}
