{ pkgs, hostName, ... }:


{
	imports = [
		./hardware
		../common/core/systemd-boot.nix
		../common/optional/gnome
		../common/optional/steam.nix
		../common/optional/fonts.nix
	];
	system.stateVersion = "23.11";
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
}
