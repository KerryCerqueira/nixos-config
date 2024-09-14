{ pkgs, config, stateVersion, hostName, ... }:

{
	imports = [
		./hardware
		../common/core/systemd-boot.nix
		../common/optional/gnome
		../common/optional/steam.nix
		../common/optional/fonts.nix
	];
	system.stateVersion = stateVersion;
	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;
	networking.hostName = hostName;
	networking.networkmanager.enable = true;
	time.timeZone = "America/Toronto";
	i18n.defaultLocale = "en_CA.UTF-8";
	services.xserver = {
		enable = true;
		videoDrivers = ["nvidia"];
		displayManager.gdm.enable = true;
		xkb = {
			layout = "us";
			variant = "";
		};
	};
	services.printing.enable = true;
	users.users.erika = {
		isNormalUser = true;
		description = "Erika";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.zsh;
	};
	sops = {
		defaultSopsFile = secrets/secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = /home/erika/.config/sops/age/keys.txt;
		# age.keyFile = config.sops.secrets."encryptionKeys/age".path;
		secrets = {
			"hashedUserPasswords/erika".neededForUsers = true;
			"encryptionKeys/age" = {};
		};
	};
}
