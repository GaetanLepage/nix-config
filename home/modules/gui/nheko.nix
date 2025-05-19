{
  programs.nheko = {
    enable = true;

    settings = {
      auth = {
        home_server = "https://matrix-client.matrix.org:443";
        user_id = "@@glepage:matrix.org";
      };
      user = {
        "window\\start_in_tray" = false;
        "window\\tray" = false;
        small_avatars_enabled = false;
      };
    };
  };
}
