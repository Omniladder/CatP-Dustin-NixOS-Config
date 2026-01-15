# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{

  users.mutableUsers = false;

  users.users.omniladder = {
    isNormalUser = true;
    description = "Omniladder";
    extraGroups = [ "wheel" "networkmanager" ];
    createHome = true;
    home = "/home/omniladder";
    hashedPassword = "$y$j9T$Y2fOum6gb144UrheY6mMc0$AzU5wyf2UpJMY/2UZJXT0bjtRrNbTb5vqbVX/RERXPD";
  };
}

