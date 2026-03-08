{ ... }:
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

    home.sessionVariables = {
        NIXOS_OZONE_WL = "1";
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
