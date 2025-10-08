{
	description = "Kerry Cerqueira's NixOS system configurations.";

	inputs = {
		catppuccin.url = "github:catppuccin/nix";
		easyeffects-presets = {
			url = "github:JackHack96/EasyEffects-Presets";
			flake = false;
		};
		flake-utils.url = "github:numtide/flake-utils";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		hyprland-config.url = "github:KerryCerqueira/hyprland-config";
		hyprls.url = "github:hyprland-community/hyprls";
		nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";
		nixos-hardware.url = "github:NixOS/nixos-hardware/master";
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nvim-config.url = "github:KerryCerqueira/nvim-config";
		shell-config = {
			url = "github:KerryCerqueira/zsh-config";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		sops-nix = {
			url = "github:Mic92/sops-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = {
		self,
		catppuccin,
		flake-utils,
		home-manager,
		nixpkgs,
		nvim-config,
		sops-nix,
		...
		}@inputs :
		flake-utils.lib.eachDefaultSystem (system:
			let
				shellArgs = inputs // { inherit system; };
				data-munge = (import ./shells/data-munge.nix) shellArgs;
			in {
				devShells.data-munge = data-munge.shell;
				apps.data-munge-server = data-munge.server;
			}
		) // {
			homeConfigurations = {
				"kerry@counter" = home-manager.lib.homeManagerConfiguration {
					pkgs = import nixpkgs { system = "x86_64-linux"; };
					modules = [
						{
							home = {
								stateVersion = "25.05";
								username = "kerry";
								homeDirectory = "/home/kerry";
							};
						}
						./users/kerry/minimal.nix
					];
					extraSpecialArgs = {
						flakeInputs = builtins.removeAttrs inputs [
							"nixpkgs"
						];
						inherit self;
					};
				};
				"kcerqueira@cruncher" = home-manager.lib.homeManagerConfiguration {
					pkgs = import nixpkgs { system = "x86_64-linux"; };
					modules = [
						{
							home = {
								stateVersion = "25.05";
								username = "kcerqueira";
								homeDirectory = "/home/kcerqueira";
							};
						}
						./users/kerry/minimal.nix
					];
					extraSpecialArgs = {
						flakeInputs = builtins.removeAttrs inputs [
							"nixpkgs"
						];
						inherit self;
					};
				};
			};
			nixosConfigurations = let
				specialArgs = {
					flakeInputs = builtins.removeAttrs inputs [
						"self"
						"nixpkgs"
					];
				};
				extraSpecialArgs = {
					flakeInputs = builtins.removeAttrs inputs [
						"nixpkgs"
					];
					inherit self;
				};
			in {
				sigmund = nixpkgs.lib.nixosSystem {
					inherit specialArgs;
					modules = [
						./hosts/sigmund
						sops-nix.nixosModules.sops
						home-manager.nixosModules.home-manager {
							home-manager.extraSpecialArgs = extraSpecialArgs;
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.kerry = {
								imports = [
									./users/kerry
									./users/kerry/hosts/sigmund
								];
							};
							home-manager.backupFileExtension = "bkp";
							home-manager.sharedModules = [
								sops-nix.homeManagerModules.sops
								catppuccin.homeModules.catppuccin
							];
						}
					];
				};
				claudius = nixpkgs.lib.nixosSystem {
					inherit specialArgs;
					modules = [
						./hosts/claudius
						sops-nix.nixosModules.sops
						home-manager.nixosModules.home-manager {
							home-manager.extraSpecialArgs = extraSpecialArgs;
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.kerry = {
								imports = [
									./users/kerry
									./users/kerry/hosts/claudius
								];
							};
							home-manager.backupFileExtension = "bkp";
							home-manager.sharedModules = [
								sops-nix.homeManagerModules.sops
								catppuccin.homeModules.catppuccin
							];
						}
					];
				};
				lazarus = nixpkgs.lib.nixosSystem {
					inherit specialArgs;
					modules = [
						./hosts/lazarus
						sops-nix.nixosModules.sops
						home-manager.nixosModules.home-manager {
							home-manager.extraSpecialArgs = extraSpecialArgs;
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.julie = import ./users/julie;
							home-manager.users.kerry = {
								imports = [
									./users/kerry
									./users/kerry/hosts/lazarus
								];
							};
							home-manager.backupFileExtension = "bkp";
							home-manager.sharedModules = [
								sops-nix.homeManagerModules.sops
								catppuccin.homeModules.catppuccin
							];
						}
					];
				};
				panza = nixpkgs.lib.nixosSystem {
					inherit specialArgs;
					modules = [
						./hosts/panza
						sops-nix.nixosModules.sops
						home-manager.nixosModules.home-manager {
							home-manager.extraSpecialArgs = extraSpecialArgs;
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.kerry = {
								imports = [
									./users/kerry
									./users/kerry/hosts/panza
								];
							};
							home-manager.users.erika = {
								imports = [
									./users/erika
									./users/erika/hosts/panza
								];
							};
							home-manager.backupFileExtension = "bkp";
							home-manager.sharedModules = [
								sops-nix.homeManagerModules.sops
								catppuccin.homeModules.catppuccin
							];
						}
					];
				};
				potato = nixpkgs.lib.nixosSystem {
					inherit specialArgs;
					modules = [
						sops-nix.nixosModules.sops
						./hosts/potato
						home-manager.nixosModules.home-manager
						{
							home-manager.extraSpecialArgs = extraSpecialArgs;
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.users.erika = {
								imports = [
									./users/erika
									./users/erika/hosts/potato
								];
							};
							home-manager.users.kerry = {
								imports = [
									./users/kerry
									./users/kerry/hosts/potato
								];
							};
							home-manager.backupFileExtension = "bkp";
							home-manager.sharedModules = [
								sops-nix.homeManagerModules.sops
								catppuccin.homeModules.catppuccin
							];
						}
					];
				};
			};
		};
}
