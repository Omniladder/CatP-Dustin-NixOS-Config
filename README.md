Must Create SSH Key Manually to use git
Must change hardware configurations to your own config
Add Boot mount must be defined in hardware
```nix
  fileSystems."/boot" = {
    device = "<UEFI File parition location '/dev/nvme0n1p1'>";
    fsType = "vfat";
  };
```
Installing Home Manager via
```shell
    sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
    sudo nix-channel --update
```
