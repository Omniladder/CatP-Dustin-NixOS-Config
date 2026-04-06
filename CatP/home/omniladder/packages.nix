{ pkgs, ... }:
{
    home.packages = [
        pkgs.claude-code
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
        pkgs.discord
        pkgs.vesktop
        pkgs.vscode
        ];

    fonts.fontconfig.enable = true;
}
