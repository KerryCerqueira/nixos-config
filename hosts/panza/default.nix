{ pkgs, config, hostName, ... }:

{
	imports = [
		./hardware
		../common/core/systemd-boot.nix
		../common/optional/hyprland
		../common/optional/steam.nix
		../common/optional/fonts.nix
		../common/optional/thunderbird.nix
	];
	system.stateVersion = "23.11";
	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;
	networking.hostName = hostName;
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
		xserver.enable = true;
		xserver.displayManager.gdm.enable = true;
		fprintd.enable = true;
		xserver = {
			xkb.layout = "us";
			xkb.variant = "";
		};
		printing.enable = true;
	};
	programs.zsh.enable = true;
	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};
	users.defaultUserShell = pkgs.zsh;
	users.users.kerry = {
		isNormalUser = true;
		description = "Kerry Cerqueira";
		hashedPasswordFile = config.sops.secrets."hashedUserPasswords/kerry".path;
		extraGroups = [ "networkmanager" "wheel" ];
	};
}
