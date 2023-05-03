{
  type = "internal/network";

  interface = "wlo1";
  interval = 0.5;

  label.connected = "   %essid%";

  format = {
    connected = "<label-connected>";
    disconnected = "";
  };

  ramp-signal = ["" "" "" "" ""];
}
