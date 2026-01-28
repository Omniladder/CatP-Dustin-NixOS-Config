{ config, pkgs, ... }:

{
   imports = [
       ../../modules/boot/systemd.nix
       ../../modules/network/networkManager.nix
       ../../modules/desktop/sddm.nix
   ];
}
