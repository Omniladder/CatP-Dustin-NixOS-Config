{ config, pkgs, ... }:


{

   users.mutableUsers = false;
   users.users.omniladder = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       git
       neovim
     ];
     initialHashedPassword = "$y$j9T$gK2JTzIjPE1v0KTmnfjJ10$/QueLfNRW9Kz2CM7mcEtJOMhhJY3MOwlcfxZOQCANq7";
   };


}
