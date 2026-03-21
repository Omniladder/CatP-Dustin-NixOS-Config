{ ... }:

{
   imports = [

    # Theming
    ../modules/themes/qt.nix
    ../modules/themes/gtk.nix

    # Tools
    ../modules/browser/browsers.nix
    ../modules/desktop/sway.nix
    ../modules/desktop/rofi.nix
    ../modules/desktop/mako.nix
    ../modules/desktop/swaylock.nix

    # Packages
      ../modules/no_setup/user.nix
   ];
}
