{ pkgs, config, stateVersion, hostName, ... }:

{
	imports = [
		./hardware
		../common/core/systemd-boot.nix
		../common/optional/gnome-minimal.nix
		../common/optional/steam.nix
		../common/optional/vpn.nix
		../common/optional/fonts.nix
	];
	system.stateVersion = stateVersion;
	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;
	networking.hostName = hostName;
	networking.networkmanager.enable = true;
	time.timeZone = "America/Toronto";
	i18n.defaultLocale = "en_CA.UTF-8";
	services.xserver.enable = true;
	services.xserver.displayManager.gdm.enable = true;
	services.fprintd.enable = true;
	services.xserver = {
		xkb.layout = "us";
		xkb.variant = "";
	};
	services.printing.enable = true;
	programs.zsh.enable = true;
	users.users.kerry = {
		isNormalUser = true;
		description = "Kerry Cerqueira";
		hashedPasswordFile = config.sops.secrets."hashedUserPasswords/kerry".path;
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.zsh;
	};
	sops = {
		defaultSopsFile = secrets/secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = config.sops.secrets."encryptionKeys/age".path;
		secrets = {
			"hashedUserPasswords/kerry".neededForUsers = true;
			"vpnConfs/bic" = {};
			"encryptionKeys/age" = {};
		};
	};
}
