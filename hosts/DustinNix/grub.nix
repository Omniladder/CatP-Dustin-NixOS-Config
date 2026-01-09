{ config, lib, pkgs, ... }:

{
   boot.loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      theme = ./grub_theme;
      efiInstallAsRemovable = true;
      useOSProber = true;
      extraEntries = ''
      menuentry "UEFI Firmware Settings" {
         fwsetup
      }
      '';
   };
}
