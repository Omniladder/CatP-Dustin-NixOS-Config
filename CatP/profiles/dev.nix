{ ... }:

{
   imports = [
    # Tools
	../modules/dev/git.nix
	../modules/dev/neovim.nix
	../modules/dev/wezterm.nix
    ../modules/dev/alacritty.nix

    # Languages
    ../modules/languages/c.nix
    ../modules/languages/rust.nix
    ../modules/languages/go.nix
    ../modules/languages/javascript.nix
    ../modules/languages/python.nix

    # Packages
    ../modules/no_setup/dev.nix
   ];
}
