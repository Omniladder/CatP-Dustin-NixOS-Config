{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
    ./configuration.nix
    ./users.nix
    ./hardware-configuration.nix
    ./grub.nix
  ];
}
