
{ config, pkgs, ... }:

{
    services.xserver.displayManager.sddm = {
	wayland.enable = true;
        enable = true;
    };
}

