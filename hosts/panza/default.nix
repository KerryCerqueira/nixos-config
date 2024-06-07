{ stateVersion, hostName, ... }:

{
	imports = [
		./hardware
		../common/core/sops-nix.nix
		../common/core/systemd-boot.nix
		../common/optional/gnome.nix
		../common/optional/steam.nix
		../common/optional/vpn.nix
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
	sops = {
		defaultSopsFile = secrets/secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = "/run/secrets/encryptionKeys/age";
		secrets = {
			"hashedUserPasswords/kerry".neededForUsers = true;
			"vpnConfs/bic" = {};
			"encryptionKeys/age" = {};
		};
	};
}
