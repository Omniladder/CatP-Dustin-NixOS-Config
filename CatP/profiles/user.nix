{ ... }:

{
   imports = [

    # Tools
      ../modules/browser/firefox.nix
      ../modules/desktop/sway.nix

    # Packages
      ../modules/no_setup/user.nix
   ];
}
