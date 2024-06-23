{ ... }@inputs:
{
  services.xserver.displayManager.sessionCommands = ''
    xrandr --output DP-0 --primary --mode 1920x1080 --rate 144 --output HDMI-0 --mode 1920x1080 --left-of DP-0
  '';
}
