{
  description = "Dustin's System Wide Set of Flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
        url = "github:nix-community/home-manager/release-25.11";
	inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim-config.url = "github:Omniladder/nvim-config";
    nvim-config.flake = false;
  };

  outputs = { self, nixpkgs, home-manager, nvim-config, ... }@inputs: 
     {
  	nix.settings.experimental-features = [ "nix-command" "flakes" ];


	nixosConfigurations.CatP = nixpkgs.lib.nixosSystem {
	   modules = [
              ./CatP/hosts/DustinNix/configuration.nix
	       home-manager.nixosModules.home-manager {
                   home-manager.useGlobalPkgs = true;
	           home-manager.useUserPackages = true;
                   home-manager.backupFileExtension = "hm-bak";

		   home-manager.extraSpecialArgs = {
		      inherit inputs;
		   };
		   
		   home-manager.users.omniladder = {
		       imports = [ ./CatP/home/omniladder/home.nix ];
		   };
	       }
           ];
	};
     };
}
