{
	description = "Kerry Cerqueira's NixOS system configurations.";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, home-manager, nixpkgs, ... }@inputs:
		let
			system = "x86_64-linux";
			stateVersion = "23.11";
			configRoot = self;
			specialArgs = {
				inherit home-manager nixpkgs system stateVersion configRoot;
			};
		in {
			nixosConfigurations = {
				inherit system;
				panza = nixpkgs.lib.nixosSystem {
					inherit specialArgs;
					modules = [
						./hosts/panza
						home-manager.nixosModules.home-manager
						{
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.kerry = import ./users/kerry/home.nix;
							home-manager.backupFileExtension = "bkp";
							home-manager.extraSpecialArgs = specialArgs;
						}
					];
				};
				potato = nixpkgs.lib.nixosSystem {
					inherit specialArgs;
					modules = [
						./hosts/potato
						home-manager.nixosModules.home-manager
						{
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.erika = import ./users/erika/home.nix;
							home-manager.backupFileExtension = "bkp";
							home-manager.extraSpecialArgs = specialArgs;
						}
					];
				};
			};
		};
}
