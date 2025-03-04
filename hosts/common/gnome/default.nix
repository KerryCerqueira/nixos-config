{ pkgs, lib,  ... }:

{
	services.xserver.desktopManager.gnome.enable = true;
	services.xserver.excludePackages = with pkgs; [ xterm ];
	environment.systemPackages = with pkgs; [
		gnomeExtensions.appindicator
		kitty
	];
	environment.gnome.excludePackages = with pkgs; [ gnome-console ];
	services.udev.packages = with pkgs; [ gnome-settings-daemon ];
	services.gnome.gnome-keyring.enable = lib.mkForce false;
	programs.ssh.startAgent = true;
	programs.dconf.enable = true;
}
