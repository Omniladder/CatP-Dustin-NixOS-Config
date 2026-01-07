{ config, pkgs, ... }:

{
  imports = [
    ./configuration.nix
    ./users.nix
    ./hardware-configuration.nix
    ./grub.nix
  ];
}
