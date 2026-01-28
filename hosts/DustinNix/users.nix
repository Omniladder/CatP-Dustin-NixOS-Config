{ config, pkgs, ... }:


{

   users.mutableUsers = false;

   users.groups.omniladder = {};

   users.users.omniladder = {
     isNormalUser = true;
     home = "/home/omniladder";

     group = "omniladder";

     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.

     # TODO: Move packages to home manager
     packages = with pkgs; [
       git
       neovim
     ];
     initialHashedPassword = "$y$j9T$gK2JTzIjPE1v0KTmnfjJ10$/QueLfNRW9Kz2CM7mcEtJOMhhJY3MOwlcfxZOQCANq7";
   };


}
