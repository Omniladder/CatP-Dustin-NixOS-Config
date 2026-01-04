{
  description = "Dustin O'Brien's Catppuccin Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
     nixosConfigurations.DustinNix = nixpkgs.lib.nixosSystem {
      modules = [ ./hosts/DustinNix ./modules ./home/omniladder ];
    };
  };
}
