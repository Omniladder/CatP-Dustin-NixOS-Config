{ pkgs, ... }:
{
   home.packages = [
    pkgs.fastfetch
    pkgs.code-cursor
    pkgs.speedtest-cli
    pkgs.font-awesome
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.catppuccin-cursors.mochaMauve
    pkgs.papirus-icon-theme
    pkgs.yazi
    pkgs.spotify-player
    pkgs.bluetuith
   ];

   fonts.fontconfig.enable = true;
}
