{ pkgs, ... }:
{
    
    systemd.user.services.eww-widgets = {
      Unit = {
        Description = "Open Eww widgets";
        After = [ "eww-daemon.service" ];
        Requires = [ "eww-daemon.service" ];
      };
    
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.eww}/bin/eww open windowOne";
      };
    
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
}
