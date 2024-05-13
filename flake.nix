{
	description = "Kerry Cerqueira's NixOS system configurations.";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, home-manager, nixpkgs, ... }@inputs:
		let
			system = "x86_64-linux";
			stateVersion = "23.11";
		in {
			nixosConfigurations = {
				inherit system;
				panza = nixpkgs.lib.nixosSystem {
					modules = [
						./hosts/panza.nix
						./userss/kerry/home.nix
					];
					specialArgs = {
						inherit home-manager nixpkgs system stateVersion;
						configRoot = self;
					};
				};
			};
		};
}
