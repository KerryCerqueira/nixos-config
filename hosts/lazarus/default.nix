{ pkgs, config, ... }:

{
	imports = [
		./hardware
		../common/systemd-boot.nix
		../common/steam.nix
		../common/fonts.nix
		../common/thunderbird.nix
	];
	system.stateVersion = "23.11";
	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;
	networking.hostName = "lazarus";
	networking.networkmanager.enable = true;
	time.timeZone = "America/Toronto";
	i18n.defaultLocale = "en_CA.UTF-8";
	sops = {
		defaultSopsFile = ./secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = let
			envKey = builtins.getEnv "SOPS_AGE_KEY_FILE";
		in
			if envKey == "" then "/etc/age/lazarus.age" else envKey;
		secrets = {
			"hashedUserPasswords/kerry".neededForUsers = true;
			"ageKeys/kerryLazarus" = {
				path = "/home/kerry/.config/sops/age/kerry_lazarus.age";
				owner = "kerry";
			};
		};
	};
	services = {
		displayManager = {
			sddm.enable = true;
			autoLogin.enable = true;
			autoLogin.user = "julie";
		};
		xserver = {
			enable = true;
			desktopManager.plasma5.enable = true;
			xkb.layout = "us";
			xkb.variant = "";
		};
		printing.enable = true;
	};
	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;
	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};
	users.users.julie= {
		isNormalUser = true;
		description = "Julie Quigley";
		extraGroups = [ "networkmanager" ];
	};
	users.users.kerry = {
		isNormalUser = true;
		description = "Kerry Cerqueira";
		hashedPasswordFile = config.sops.secrets."hashedUserPasswords/kerry".path;
		extraGroups = [ "networkmanager" "wheel" ];
	};
}
