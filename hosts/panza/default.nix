{ pkgs, config, ... }:

{
	imports = [
		./hardware
		../common/systemd-boot.nix
		../common/hyprland
		../common/steam.nix
		../common/fonts.nix
		../common/thunderbird.nix
	];
	system.stateVersion = "23.11";
	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;
	networking.hostName = "panza";
	networking.networkmanager.enable = true;
	time.timeZone = "America/Toronto";
	i18n.defaultLocale = "en_CA.UTF-8";
	sops = {
		defaultSopsFile = ./secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = "/home/kerry/.config/sops/age/keys.txt";
		secrets = {
			"hashedUserPasswords/kerry".neededForUsers = true;
			"encryptionKeys/age" = {};
		};
	};
	services = {
		xserver = {
			enable = true;
			displayManager.gdm.enable = true;
			xkb.layout = "us";
			xkb.variant = "";
		};
		fprintd.enable = true;
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
		users.kerry = {
			isNormalUser = true;
			description = "Kerry Cerqueira";
			hashedPasswordFile = config.sops.secrets."hashedUserPasswords/kerry".path;
			extraGroups = [ "networkmanager" "wheel" ];
		};
	};
}
