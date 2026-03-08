{ pkgs, ... }:
{
   home.packages = [
    pkgs.fastfetch
    pkgs.code-cursor
    pkgs.speedtest-cli
    pkgs.font-awesome
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.catppuccin-cursors.mochaMauve
   ];

   fonts.fontconfig.enable = true;
}
