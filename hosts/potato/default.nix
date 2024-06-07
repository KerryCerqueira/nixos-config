# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ stateVersion, hostName, ... }:


{
	imports = [
		./hardware
		../common/core/systemd-boot.nix
		../common/optional/gnome.nix
		../common/optional/steam.nix
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
}
