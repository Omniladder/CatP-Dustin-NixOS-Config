{ pkgs, ... }:
{
   home.stateVersion = "25.11";

   imports = [
       ../../profiles/user.nix
       ../../profiles/dev.nix
       ./packages.nix
       ./nvim_setup.nix
   ];

   home.username = "omniladder";

   programs.home-manager.enable = true;

   programs.git = {
        settings = {
            user.name = "Omniladder";
	        user.email = "dustintobrien@gmail.com";
	    };
   };

    
    xdg.enable = true;
    
    xdg.configFile."wallpapers/desktop.jpg".source = ./assets/desktop.jpg;
    xdg.configFile."niri/config.kdl".source = ./config/niri.kdl;

}
