{ pkgs, config, ... }:
{
    home.stateVersion = "25.11";
    programs.home-manager.enable = true;

    imports = [
       ../../profiles/user.nix
       ../../profiles/dev.nix
       ./packages.nix
       ./nvim_setup.nix
       ./load_eww.nix
    ];

    home.username = "omniladder";
    fonts.fontconfig.enable = true;

    home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;

        package = pkgs.catppuccin-cursors.mochaDark;
        name = "catppuccin-mocha-dark-cursors";

        size = 24;
    };

    home.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        XCURSOR_THEME = "catppuccin-mocha-dark-cursors";
        XCURSOR_SIZE = "24";
    };

    programs.git.settings = {
        user.name = "Omniladder";
	    user.email = "dustintobrien@gmail.com";
    };
    
    xdg.enable = true;
    
    xdg.configFile."wallpapers/nix.png".source = ./assets/nix.png;
    xdg.configFile."niri".source = ./config/niri;
    xdg.configFile."eww".source = ./config/eww;
    xdg.configFile."alacritty".source = ./config/alacritty;
    xdg.configFile."rofi".source = ./config/rofi;
    xdg.configFile."Kvantum".source = ./config/kvantum;
    xdg.configFile."mako".source = ./config/mako;
    xdg.configFile."swaylock".source = ./config/swaylock;


    xdg.configFile."Kvantum/catppuccin-mocha-blue".source = ./config/kvantum/catppuccin-mocha-blue;
    home.file.".config/environment.d/10-ozone.conf".text = ''
      NIXOS_OZONE_WL=1
    '';
    home.file.".p10k.zsh".source = ./config/.p10k.zsh;

    programs.zsh.shellAliases = {
        switch = "sudo nixos-rebuild switch --flake /home/omniladder/flakes#CatP --show-trace";
        packages = "nvim ~/flakes/CatP/home/omniladder/packages.nix";
        flakes = "nvim ~/flakes";
    };

}
