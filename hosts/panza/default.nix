{ config, pkgs, configRoot, stateVersion, ... }:

{
	imports = [
		./hardware
		"${configRoot}/hosts/common/optional/gnome.nix"
	];
	system.stateVersion = stateVersion;
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
	services.fprintd.enable = true;
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
			updateResolvConf = true;
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
		STEAM_FORCE_DESKTOPUI_SCALING = "2";
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
