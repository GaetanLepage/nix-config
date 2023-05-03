pkgs: {
  type = "custom/script";

  interval = 1;

  exec = pkgs.writeShellScript "dunst-polybar" ''
    ${builtins.readFile ./helper.sh}

    if [ "$(dunstctl is-paused)" == "true" ]; then
        print_line "  " $RED
    else
        # print_line "  " $GREEN
        echo "  "
    fi
  '';

  click-left = "dunstctl set-paused toggle";

  format.padding = 0;
}
