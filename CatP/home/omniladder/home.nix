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

    home.sessionVariables = {
        NIXOS_OZONE_WL = "1";
    };


    programs.git.settings = {
        user.name = "Omniladder";
	    user.email = "dustintobrien@gmail.com";
    };
    
    xdg.enable = true;
    
    xdg.configFile."wallpapers/nix.png".source = ./assets/nix.png;
    xdg.configFile."niri/config.kdl".source = ./config/niri.kdl;
    xdg.configFile."eww".source = ./config/eww;
    home.file.".config/environment.d/10-ozone.conf".text = ''
      NIXOS_OZONE_WL=1
    '';

}
