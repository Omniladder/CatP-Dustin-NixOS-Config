{ config, pkgs, ... }:

{
   imports = [
      ../modules/browser/firefox.nix
   ];
}
