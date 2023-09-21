{ pkgs, ... }:
{
    home.packages = [ pkgs.swww pkgs.eww ];

    systemd.user.services.swww-daemon = {
        Unit = {
          Description = "swww wallpaper daemon";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };
    
        Service = {
          ExecStart = "${pkgs.swww}/bin/swww-daemon";
          Restart = "on-failure";
        };
    
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
    };

    systemd.user.services.eww-daemon = {
      Unit = {
        Description = "Eww widget daemon";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
    
      Service = {
        ExecStart = "${pkgs.eww}/bin/eww daemon --no-daemonize";
        Restart = "on-failure";
        RestartSec = 1;
      };
    
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };


}
