{
  "colors" = {
    background = "#CC20222B";
    background-alt = "#373B41";
    foreground = "#C5C8C6";
    primary = "#F0C674";
    secondary = "#8ABEB7";
    alert = "#A54242";
    warning = "#e02121";
    disabled = "#707880";
  };

  "bar/top" = {
    width = "100%";
    height = "20pt";
    radius = "0";

    monitor = "\${env:MONITOR:}";

    background = "\${colors.background}";
    foreground = "\${colors.foreground}";

    line-size = "2pt";

    border-size = "0pt";
    border-color = "#00000000";

    padding-left = 0;
    padding-right = 1;

    module-margin = 1;

    separator = "|";
    separator-foreground = "\${colors.disabled}";

    font-0 = "monospace:size=10;2";
    font-1 = "HanaMinA:size=10;2";

    modules-left = "xworkspaces i3 xwindow";
    modules-right = "pulseaudio filesystem network memory cpu battery date";

    cursor-click = "pointer";
    cursor-scroll = "ns-resize";

    enable-ipc = "true";

    tray-position = "right";
  };

  "module/xworkspaces" = {
    type = "internal/xworkspaces";

    label-active = "%name%";
    label-active-background = "\${colors.background-alt}";
    label-active-underline= "\${colors.primary}";
    label-active-padding = "1";

    label-occupied = "%name%";
    label-occupied-padding = 1;

    label-urgent = "!%name%!";
    label-urgent-background = "\${colors.alert}";
    label-urgent-padding = 1;

    label-empty = "%name%";
    label-empty-foreground = "\${colors.disabled}";
    label-empty-padding = 1;

    pin-workspaces = "true";
  };

  "module/i3" = {
    type = "internal/i3";
    format = "<label-mode>";
  };
  "module/xwindow" = {
    type = "internal/xwindow";
    label = "%title:0:60:...%";
  };
  "module/filesystem" = {
    type = "internal/fs";
    interval = "25";

    mount-0 = "/";

    format-warn = "<label-warn>";

    label-mounted = "%free% (%percentage_used%%)";

    label-warn-foreground = "\${colors.warning}";
    label-warn = "%free% (%percentage_used%%!)";

    label-unmounted = "%mountpoint% not mounted";
    label-unmounted-foreground = "\${colors.disabled}";
  };

  "module/battery" = {
    type = "internal/battery";
    battery = "BAT1";
    adapter = "ADP1";

    low-at = "20";

    format-full = "  100%";

    format-charging = "<animation-charging>  <label-charging>";

    format-discharging = "<ramp-capacity>  <label-discharging>";

    format-low = "! <ramp-capacity>  <label-low> !";

    label-charging = "%percentage%%";
    label-discharging = "%percentage%%";
    label-low = "%percentage%%";
    label-low-foreground = "\${colors.warning}";

    ramp-capacity-0 = "";
    ramp-capacity-1 = "";
    ramp-capacity-2 = "";
    ramp-capacity-3 = "";
    ramp-capacity-4 = "";

    animation-charging-0 = "";
    animation-charging-1 = "";
    animation-charging-2 = "";
    animation-charging-3 = "";
    animation-charging-4 = "";
    animation-charging-framerate = "750";
  };

  "module/network" = {
    type = "internal/network";
    interface = "enp3s0";
    interface-type = "wired";
    accumulate-stats = "true";

    format-connected = "<label-connected>";
    label-connected = " %downspeed%";
  };

  "module/pulseaudio" = {
    type = "internal/pulseaudio";

    format-volume-prefix-foreground = "\${colors.primary}";
    format-volume = "<ramp-volume> <label-volume>";

    ramp-volume-0 = "";
    ramp-volume-1 = "";
    ramp-volume-2 = "";

    label-volume = "%percentage%%";

    format-muted = "<label-muted>";
    label-muted = "󰝟 %percentage%%";
    label-muted-foreground = "\${colors.disabled}";
  };

  "module/memory" = {
    type = "internal/memory";
    interval = "2";
    format-prefix = "RAM ";
    format-prefix-foreground = "\${colors.primary}";
    label = "%percentage_used:2%%";
  };

  "module/cpu" = {
    type = "internal/cpu";
    interval = "2";
    format-prefix = "CPU ";
    format-prefix-foreground = "\${colors.primary}";
    label = "%percentage:2%%";
  };

  "module/date" = {
    type = "internal/date";
    interval = "1";

    date = "%T";
    date-alt = "%a, %b %d (W%W) %T";

    label = "%date%";
    label-foreground = "\${colors.primary}";
  };

  "settings" = {
    screenchange-reload = "true";
    pseudo-transparency = "false";
  };

}
