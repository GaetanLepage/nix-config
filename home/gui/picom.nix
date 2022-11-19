{
    services.picom = {
        enable = true;

        backend = "glx";

        settings.blur = {
            method = "gaussian";
            size = 10;
            deviation = 10.0;
        };
    };
}
