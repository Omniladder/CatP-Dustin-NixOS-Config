{ config, pkgs, ... }:

{
    services.xserver.enable = true;

    environment.systemPackages = [(
        pkgs.catppuccin-sddm.override {
            flavor = "mocha";
            accent = "mauve";
            font = "Noto Sans";
            fontSize = "9";
#            background = "${./wallpaper.png}";
            loginBackground = true;
        }
    )];

    services.displayManager.sddm = {
        enable = true;
        theme = "catppuccin-mocha-mauve";
        package = pkgs.kdePackages.sddm;
    };
}
