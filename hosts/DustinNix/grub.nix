{ config, lib, pkgs, ... }:

{
   boot.loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      theme = ./grub_theme;
      efiInstallAsRemovable = true;
      extraEntries = ''
      menuentry "UEFI Firmware Settings" {
         fwsetup
      }
      '';
   };
}
