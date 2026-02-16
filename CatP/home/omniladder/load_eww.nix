{ pkgs, ... }:
{
    
    systemd.user.services.eww-widgets = {
      Unit = {
        Description = "Open Eww widgets";
        After = [ "graphical-session.service" ];
        Requires = [ "eww-daemon.service" ];
        PartOf = [ "graphical-session.service" ];
      };
    
      Service = {
        ExecStart = "${pkgs.eww}/bin/eww daemon --no-daemonize";
        ExecStartPost = "${pkgs.eww}/bin/eww open windowOne";
        Restart = "on-failure";
      };
    
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
}
