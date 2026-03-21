{ pkgs, ... }:

{
    home.packages = with pkgs; [
        mako
        libnotify
    ];

    services.mako.enable = true;
}
