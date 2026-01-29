{ config, pkgs, ... }:

{
   imports = [
       ../modules/system/systemd.nix
       ../modules/system/home-manager.nix
       ../modules/network/networkManager.nix
       ../modules/desktop/sddm.nix
       ../modules/desktop/niri.nix
   ];
}
