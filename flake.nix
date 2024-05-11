{
  description = "Kerry Cerqueira's NixOS system configurations.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
	  nixosConfigurations = {
		  system = "x86_64-linux";
		  panza = nixpkgs.lib.nixosSystem {
			  modules = [
				  ./hosts/panza.nix
			  ];
			  specialArgs = { configRoot = self; };
		  };
	  };
  };
}
