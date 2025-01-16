{ pkgs, ... }:


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
			extraGroups = [ "networkmanager" "wheel" ];
			shell = pkgs.zsh;
		};
	};
}
