
{ config, pkgs, ... }:

{
    services.xserver.displayManager.sddm = {
	wayland.enable = true;
	theme = "./sddm-themes/Themes/astronaut.conf";
        enable = true;
    };
}

