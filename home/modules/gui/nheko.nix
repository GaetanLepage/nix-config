{
  programs.nheko = {
    enable = true;

    settings = {
      general.disable_certificate_validation = false;

      auth = {
        access_token = "";
        device_id = "WGVZZDRNHV";
        home_server = "https://matrix-client.matrix.org:443";
        user_id = "@@glepage:matrix.org";
      };

      settings.scale_factor = 1.0;
      user = {
        alert_on_notification = false;
        animate_images_on_hover = true;
        desktop_notifications = true;
        fancy_effects = false;
        font_size = 14;
        markdown_enabled = true;
        reduced_motion = true;
        small_avatars_enabled = false;
        sort_by_unread = true;
        space_notifications = true;
        theme = "dark";
        typing_notifications = true;
        use_identicon = true;
        use_stun_server = false;
        "window\start_in_tray" = false;
        "window\tray" = false;
      };
    };
  };
}
