{ config, pkgs, ... }:

{
	imports = [
		./hardware
		../common/grub.nix
		../common/steam.nix
		../common/thunderbird.nix
		../common/shell.nix
		../common/gnome
	];
	environment.gnome.excludePackages = with pkgs; [
		evince
		gnome-music
		gnome-text-editor
		gnome-connections
	];
	system.stateVersion = "24.11";
	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;
	networking.hostName = "claudius";
	networking.networkmanager.enable = true;
	time.timeZone = "America/Toronto";
	i18n.defaultLocale = "en_CA.UTF-8";
	services = {
		displayManager.gdm.enable = true;
		xserver = {
			enable = true;
			xkb.layout = "us";
			xkb.variant = "";
		};
		fwupd.enable = true;
		fprintd.enable = true;
		printing.enable = true;
	};
	users = {
		users = {
			kerry = {
				isNormalUser = true;
				description = "Kerry Cerqueira";
				extraGroups = [ "networkmanager" "wheel" ];
			};
			erika = {
				isNormalUser = true;
				description = "Erika Titley";
				extraGroups = [ "networkmanager" "wheel" ];
			};
		};
	};
}
