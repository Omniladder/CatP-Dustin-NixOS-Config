{ config, pkgs, ... }:

{


   home.stateVersion = "25.11";

   imports = [
       ../../profiles/user/user.nix
   ];

   home.username = "omniladder";

   programs.home-manager.enable = true;
}
