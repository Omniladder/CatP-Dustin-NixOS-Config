{ pkgs, ... }:
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

  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.catppuccin-cursors.mochaDark;
      name = "catppuccin-mocha-dark-cursors";
      size = 24;
    };
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
    home.file.".config/environment.d/10-ozone.conf".text = ''
      NIXOS_OZONE_WL=1
    '';
    home.file.".p10k.zsh".source = ./config/.p10k.zsh;

}
