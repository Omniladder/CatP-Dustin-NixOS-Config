{ ... }:

{
   imports = [

    # Tools
      ../modules/browser/firefox.nix
      ../modules/desktop/sway.nix
      ../modules/desktop/rofi.nix

    # Packages
      ../modules/no_setup/user.nix
   ];
}
