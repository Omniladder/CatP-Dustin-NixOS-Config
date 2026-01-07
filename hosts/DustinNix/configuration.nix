{ config, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "DustinNix"; # Define your hostname.

  networking.networkmanager.enable = true;

  fileSystems."/boot" = {
      device = "/dev/nvme0n1p1";
      fsType = "vfat";
      options = [ "nofail" ];
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

