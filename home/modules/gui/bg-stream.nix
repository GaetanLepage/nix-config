{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "bg_stream";

      runtimeInputs = with pkgs; [
        libnotify
        mpv
      ];

      text = ''
        play_stream() {
          if pgrep mpv > /dev/null; then
            notify-send "MPV is already running.\nRun '$0 stop'."
          fi

          notify-send "Starting '$stream_name' stream"
          mpv --no-video "https://www.youtube.com/watch?v=$1"
        }

        stream_name=$1

        case $stream_name in
          stop)
            killall mpv
            notify-send "Stopping stream"
            ;;

          lofi)
            play_stream "jfKfPfyJRdk"
            ;;

          trap)
            # Nation
            play_stream "6Qq2OMFh8Pc"
            ;;
        esac
      '';
    })
  ];
}
