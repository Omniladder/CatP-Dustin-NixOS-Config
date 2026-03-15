{ pkgs, ... }:

{
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    chromium
    brave
    librewolf
    qutebrowser
    vivaldi
  ];
}
