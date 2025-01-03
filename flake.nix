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
		hyprland = {
			type = "git";
			url = "https://github.com/hyprwm/Hyprland";
			submodules = true;
			inputs.nixpkgs.follows = "nixpkgs";
		};
		hyprspace = {
			url = "github:KZDKM/Hyprspace";
			inputs.hyprland.follows = "hyprland";
		};
		hyprgrass = {
			url = "github:horriblename/hyprgrass";
			inputs.hyprland.follows = "hyprland";
		};
		hyprls.url = "github:hyprland-community/hyprls";
		catppuccin.url = "github:catppuccin/nix";
	};

	outputs = { nixpkgs, home-manager, sops-nix, catppuccin, ... } @inputs: {
		nixosConfigurations = {
			system = "x86_64-linux";
			panza = let
				specialArgs = {
					inherit inputs;
					hostName = "panza";
				};
			in nixpkgs.lib.nixosSystem {
					inherit specialArgs;
					modules = [
						./hosts/panza
						sops-nix.nixosModules.sops
						catppuccin.nixosModules.catppuccin
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
					inherit inputs;
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
