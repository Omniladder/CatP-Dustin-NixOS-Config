{ config, pkgs, ... }:

{
  imports = [ ./packages.nix ./git.nix ./WM ];
}
