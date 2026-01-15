{ pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
     git
     neovim
     grub2
     kdePackages.sddm
     niri
     bash
     firefox
     wezterm
     stow
   ];

}
