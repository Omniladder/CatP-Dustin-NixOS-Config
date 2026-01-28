{ config, pkgs, ... }:

{
    home.packages = [ 
         pkgs.sddm
    ];
}
