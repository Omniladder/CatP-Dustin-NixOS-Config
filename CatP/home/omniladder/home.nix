{ config, pkgs, home, ... }:

{
   home.stateVersion = "25.11";

   imports = [
       ../../profiles/user.nix
       ../../profiles/dev.nix
       ./keybind.nix
   ];

   home.username = "omniladder";

   programs.home-manager.enable = true;

   programs.git = {
        settings = {
           user.name = "Omniladder";
	   user.email = "dustintobrien@gmail.com";
	};
   };

}
