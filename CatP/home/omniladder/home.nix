{ config, pkgs, home, ... }:

{
   home.stateVersion = "25.11";

   imports = [
       ../../profiles/user.nix
       ../../profiles/dev.nix
   ];

   home.username = "omniladder";

   programs.home-manager.enable = true;

   programs.git = {
        settings = {
           user.name = "Omniladder";
	   user.email = "dustintobrien@gmail.com";
	};
   };

   xdg.configFile."niri/config.kdl".source = ./config/niri.kdl;
   xdg.configFile."nvim".source = ./config/nvim-config;
   programs.neovim.defaultEditor = true;



}
