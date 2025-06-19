{ pkgs, ... }:

{
	imports = [
		./hardware
		../common/grub.nix
		../common/steam.nix
		../common/thunderbird.nix
		../common/shell.nix
		../common/gnome.nix
	];
	environment.gnome.excludePackages = with pkgs; [
		evince
		gnome-music
		gnome-text-editor
		gnome-connections
	];
	system.stateVersion = "24.11";
	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;
	networking.hostName = "claudius";
	networking.networkmanager.enable = true;
	time.timeZone = "America/Toronto";
	i18n.defaultLocale = "en_CA.UTF-8";
	sops = {
		defaultSopsFile = ./secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = let
			envKey = builtins.getEnv "SOPS_AGE_KEY_FILE";
		in
			if envKey == "" then "/etc/age/claudius.age" else envKey;
		secrets = {
			"ageKeys/kerryMaster" = {
				path = "/home/kerry/.config/sops/age/kerry_master.age";
				owner = "kerry";
			};
			"ageKeys/kerryPotato" = {
				path = "/home/kerry/.config/sops/age/kerry_potato.age";
				owner = "kerry";
			};
			"ageKeys/kerryLazarus" = {
				path = "/home/kerry/.config/sops/age/kerry_lazarus.age";
				owner = "kerry";
			};
			"ageKeys/kerryClaudius" = {
				path = "/home/kerry/.config/sops/age/kerry_claudius.age";
				owner = "kerry";
			};
		};
	};
	services = {
		displayManager.gdm.enable = true;
		xserver = {
			enable = true;
			xkb.layout = "us";
			xkb.variant = "";
		};
		fwupd.enable = true;
		printing.enable = true;
	};
	users = {
		users = {
			kerry = {
				isNormalUser = true;
				description = "Kerry Cerqueira";
				extraGroups = [ "networkmanager" "wheel" ];
			};
			erika = {
				isNormalUser = true;
				description = "Erika Titley";
				extraGroups = [ "networkmanager" "wheel" ];
			};
		};
	};
}
