{ pkgs, ... }:
{
    home.packages = with pkgs; [
        python3
        gcc
        cargo
        go
        nodejs
        brightnessctl
    ];
}
