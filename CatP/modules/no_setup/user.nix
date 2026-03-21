{ pkgs, ... }:
{
    home.packages = with pkgs; [
        unzip
        brightnessctl
        obs-studio
    ];
}
