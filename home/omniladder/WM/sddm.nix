
{ config, pkgs, ... }:

{
#   services.xserver.displayManager.sddm.wayland.enable = true;
#   services.xserver.displayManager.sddm.enable = true;
    services.xserver.displayManager.sddm = {
	wayland.enable = true;
        enable = true;
    };
}

