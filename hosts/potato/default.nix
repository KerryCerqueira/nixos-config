{ pkgs, config, ... }:


{
	imports = [
		./hardware
		../common/systemd-boot.nix
		../common/gnome
		../common/steam.nix
		../common/fonts.nix
	];
	system.stateVersion = "23.11";
	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;
	networking.hostName = "potato";
	networking.networkmanager.enable = true;
	time.timeZone = "America/Toronto";
	i18n.defaultLocale = "en_CA.UTF-8";
	sops = {
		defaultSopsFile = ./secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = let
			envKey = builtins.getEnv "SOPS_AGE_KEY_FILE";
		in
			if envKey == "" then "/etc/age/potato.age" else envKey;
		secrets = {
			"hashedUserPasswords/kerry".neededForUsers = true;
			"hashedUserPasswords/erika".neededForUsers = true;
			"ageKeys/kerryPotato" = {
				path = "/home/kerry/.config/sops/age/kerry_potato.age";
				owner = "kerry";
			};
			"ageKeys/erikaMaster" = {
				path = "/home/erika/.config/sops/age/erika_master.age";
				owner = "erika";
			};
		};
	};
	services = {
		xserver = {
			enable = true;
			videoDrivers = ["nvidia"];
			displayManager.gdm.enable = true;
			xkb = {
				layout = "us";
				variant = "";
			};
		};
		printing.enable = true;
	};
	programs = {
		zsh.enable = true;
		neovim = {
			enable = true;
			defaultEditor = true;
		};
	};
	users = {
		defaultUserShell = pkgs.zsh;
		users.erika = {
			isNormalUser = true;
			description = "Erika";
			hashedPasswordFile = config.sops.secrets."hashedUserPasswords/erika".path;
			extraGroups = [ "networkmanager" "wheel" ];
		};
		users.kerry = {
			isNormalUser = true;
			descriptin = "Kerry Cerqueira";
			hashedPasswordFile = config.sops.secrets."hashedUserPasswords/kerry".path;
			extraGroups = [ "networkmanager" "wheel" ];
		};
	};
}
