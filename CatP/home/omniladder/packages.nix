{ pkgs, ... }:
{
   home.packages = [
    pkgs.fastfetch
    pkgs.code-cursor
    pkgs.speedtest-cli
    pkgs.font-awesome
   ];
}
