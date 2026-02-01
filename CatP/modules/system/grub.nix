{config, pkgs, ...}:
{
    boot.loader = {
        efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot";
        };

        grub = {
            enable = true;
            efiSupport = true;
            device = "nodev";
            theme = ./grub_theme;
            #efiInstallAsRemovable = true;
            useOSProber = true;
            extraEntries =  ''
              menuentry "   UEFI Firmware Settings" {
                fwsetup
            }
            '';
        };
    };
    
}
