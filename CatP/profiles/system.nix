{ config, pkgs, ... }:

{
   imports = [
       ../modules/system/grub.nix
       ../modules/system/home-manager.nix
       ../modules/system/sddm.nix
       ../modules/network/networkManager.nix
       ../modules/desktop/niri.nix
   ];
}
