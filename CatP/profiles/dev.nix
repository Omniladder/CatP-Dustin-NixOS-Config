{ config, pkgs, ... }:

{
   imports = [
	../modules/dev/git.nix
	../modules/dev/neovim.nix
   ];
}
