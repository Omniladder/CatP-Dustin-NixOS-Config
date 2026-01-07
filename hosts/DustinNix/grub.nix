{ config, lib, pkgs, ... }:

{
   boot.loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      splashImage = ../../assets/images/grub.png;
   };

}
