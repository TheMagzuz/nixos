{ pkgs, lib, ... }: 
let
    locker = "${pkgs.i3lock}/bin/i3lock --nofork"; 
in rec {
  focus.wrapping = "workspace";
  focus.mouseWarping = true;
  fonts = {
    names = [ "monospace" ];
    size = 10.0;
  };
  gaps.inner = 8;
  gaps.outer = 8;
  menu = "${pkgs.rofi}/bin/rofi -show drun";
  modifier = "Mod4";
  terminal = "kitty";
  workspaceAutoBackAndForth = true;
  bars = [];
  window = {
    border = 1;
    titlebar = false;
  };
  assigns = {
    "2" = [{ class = "Discord"; }];
  };
  keybindings = let
    scratchpadCmd = cmd: "exec ${terminal} --class 'scratchpad' -T '${cmd}' -o confirm_os_window_close=0 ${cmd}";
  in lib.mkOptionDefault {
    # Moving around
    "${modifier}+h" = "focus left";
    "${modifier}+j" = "focus down";
    "${modifier}+k" = "focus up";
    "${modifier}+l" = "focus right";
    "${modifier}+shift+h" = "move left";
    "${modifier}+shift+j" = "move down";
    "${modifier}+shift+k" = "move up";
    "${modifier}+shift+l" = "move right";
    "${modifier}+comma" = "focus output left";
    "${modifier}+period" = "focus output right";
    "${modifier}+shift+comma" = "move container to output left";
    "${modifier}+shift+period" = "move container to output right";

    "${modifier}+q" = "kill";

    # Layouts
    "${modifier}+n" = "split h";
    "${modifier}+v" = "split v";
    "${modifier}+f" = "fullscreen toggle";
    "${modifier}+t" = "layout stacking";
    "${modifier}+w" = "layout tabbed";
    "${modifier}+e" = "layout toggle split";
    "${modifier}+space" = "focus mode_toggle";
    "${modifier}+a" = "focus parent";
    "${modifier}+shift+d" = "focus child";

    # Opening stuff
    "${modifier}+p" = "exec ${menu}";
    "${modifier}+b" = "exec librewolf";
    "${modifier}+Shift+b" = "exec librewolf --private-window";
    "${modifier}+Shift+s" = "exec --no-startup-id maim -s | xclip -selection clipboard -t image/png";
    "${modifier}+grave" = scratchpadCmd "bc ${./.bc}";
    "${modifier}+Shift+grave" = scratchpadCmd "units";
    "${modifier}+ctrl+l" = ''exec --no-startup-id "${pkgs.libnotify}/bin/notify-send 'Going to sleep'; sleep 1; ${pkgs.xorg.xset}/bin/xset dpms force off; ${locker}"'';

    # Extra utilities
    "${modifier}+m" = "exec i3-input -F 'mark %s' -l 1 -P 'Mark: '";
    "${modifier}+g" = "exec i3-input -F '[con_mark=\"%s\"] focus' -l 1 -P 'Goto: '";
    "${modifier}+Shift+q" = "exec \"i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes, exit i3' 'i3-msg exit'\"";

    # Volume control
    "XF86AudioLowerVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_SINK@ 2%-";
    "XF86AudioRaiseVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_SINK@ 2%+";
    "XF86AudioMute" = "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_SINK@ toggle";

    # Delete the default bindings that we don't care about
    "${modifier}+Shift+e" = null;
    "${modifier}+Shift+c" = null;
  };
  window.commands = [
    {
      command = "floating enable, resize set 800 600";
      criteria = {
        class = "scratchpad";
      };
    }
  ];
  startup = [
    { command = "i3-msg workspace 1"; notification = false; }
    { command = "exec --no-startup-id xss-lock --transfer-sleep-lock -- ${locker}"; notification = false; }
  ];
}
