{ ... }@inputs:
{
  services.xserver.displayManager.sessionCommands = ''
    xrandr --output DP-1 --primary --mode 1920x1080 --rate 144 --output HDMI-1 --mode 1920x1080 --left-of DP-1
  '';
}
