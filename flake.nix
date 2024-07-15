{
	description = "Kerry Cerqueira's NixOS system configurations.";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		sops-nix = {
			url = "github:Mic92/sops-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nvim-config = {
			url = "github:KerryCerqueira/nvim-config";
			flake = false;
		};
		zsh-config = {
			url = "github:KerryCerqueira/zsh-config";
			flake = false;
		};
	};

	outputs = { self, nixpkgs, home-manager, sops-nix, nvim-config, ... }@inputs:
		let
			system = "x86_64-linux";
			stateVersion = "23.11";
			configRoot = self;
		in {
			nixosConfigurations = {
				inherit system;
				panza = let
					specialArgs = {
						inherit inputs stateVersion configRoot;
						hostName = "panza";
					};
				in nixpkgs.lib.nixosSystem {
					inherit specialArgs;
					modules = [
						sops-nix.nixosModules.sops
						./hosts/panza
						home-manager.nixosModules.home-manager {
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.kerry = import ./users/kerry/home.nix;
							home-manager.backupFileExtension = "bkp";
							home-manager.extraSpecialArgs = specialArgs;
						}
					];
				};
				potato = let
					specialArgs = {
						inherit inputs stateVersion configRoot;
						hostName = "potato";
					};
				in nixpkgs.lib.nixosSystem {
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
