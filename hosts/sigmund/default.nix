{ pkgs, ... }:

{
	imports = [
		./hardware
		../common/grub.nix
		../common/thunderbird.nix
		../common/shell.nix
		../common/gnome.nix
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
	networking.hostName = "sigmund";
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
		printing.enable = true;
	};
	users = {
		users = {
			kerry = {
				isNormalUser = true;
				description = "Kerry Cerqueira";
				extraGroups = [ "networkmanager" "wheel" ];
			};
		};
	};
}
