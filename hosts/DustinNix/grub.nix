{ config, lib, pkgs, ... }:

{
   boot.loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      theme = ../../assets/grub_theme;
   };

}
