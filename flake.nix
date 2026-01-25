{
  description = "Dustin's System Wide Set of Flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
        url = "github:nix-community/home-manager";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
     let
        system = "x86_64-linux";
     in {
 
  	nix.settings.experimental-features = [ "nix-command" "flakes" ];
       
	nixosConfigurations.CatP = nixpkgs.lib.nixosSystem {
           inherit system;
	   modules = [
               ./CatP

	       home-manager.nixosModules.home-manager {
                   home-manager.useGlobalPkgs = true;
	           home-manager.useUserPackages = true;

		   home-manager.users.omniladder = import ./CatP/home/omniladder/home.nix;
	       }

           ];
	};
     };
}
