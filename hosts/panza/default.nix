{ config, pkgs, configRoot, stateVersion, ... }:

{
	imports = [
		./hardware-configuration.nix
		./hardware-configuration-xtra.nix
		"${configRoot}/hosts/common/optional/gnome-minimal.nix"
	];
	system.stateVersion = stateVersion;
	fileSystems."/home" = {
		device = "/dev/disk/by-uuid/c67ed632-d694-454d-b39e-95322d23d0a5";
		fsType = "ext4";
	};
	nix.settings.experimental-features = ["nix-command" "flakes"];
	boot.loader.systemd-boot.enable = true;
	boot.loader.systemd-boot.configurationLimit = 2;
	boot.loader.efi.canTouchEfiVariables = true;
	networking.hostName = "panza";
	networking.networkmanager.enable = true;
	time.timeZone = "America/Toronto";
	i18n.defaultLocale = "en_CA.UTF-8";
	services.xserver.enable = true;
	services.xserver.displayManager.gdm.enable = true;
	services.xserver = {
		xkb.layout = "us";
		xkb.variant = "";
	};
	services.printing.enable = true;

	sops = {
		defaultSopsFile = "${configRoot}/secrets/secrets.yaml";
		defaultSopsFormat = "yaml";
		age.keyFile = "/home/kerry/.config/sops/age/keys.txt";
		secrets = {
			"hashedUserPasswords/kerry".neededForUsers = true;
			"vpnConfs/bic" = {};
			"encryptionKeys/age" = {};
		};
	};
	services.openvpn.servers = {
		bic = {
			autoStart = false;
			config = "config ${config.sops.secrets."vpnConfs/bic".path}";
		};
	};
	users.users.kerry = {
		isNormalUser = true;
		description = "Kerry Cerqueira";
		hashedPasswordFile = config.sops.secrets."hashedUserPasswords/kerry".path;
		extraGroups = [ "networkmanager" "wheel" ];
	};
	nixpkgs.config.allowUnfree = true;
	environment.systemPackages = with pkgs; [
		kitty
		easyeffects
	];
	fonts.packages = with pkgs ; [
		iosevka
		(nerdfonts.override {fonts = ["Iosevka"];})
	];
	environment.variables = {
		ZDOTDIR = "$HOME/.config/zsh";
	};
	users.defaultUserShell = pkgs.zsh;
	programs = {
		zsh.enable = true;
		dconf.enable = true;
		neovim = {
			enable = true;
			defaultEditor = true;
		};
		steam.enable = true;
	};
}
