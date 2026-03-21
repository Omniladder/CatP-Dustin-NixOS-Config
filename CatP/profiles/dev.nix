{ ... }:

{
   imports = [
    # Tools
	../modules/dev/git.nix
	../modules/dev/neovim.nix
	../modules/dev/wezterm.nix
    ../modules/dev/alacritty.nix
    ../modules/dev/zsh.nix
    ../modules/dev/tmux.nix

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
