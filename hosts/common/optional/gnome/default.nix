{ pkgs, lib,  ... }:

{
	services.xserver.desktopManager.gnome.enable = true;
	environment.systemPackages = with pkgs; [ gnomeExtensions.appindicator ];
	services.udev.packages = with pkgs; [ gnome-settings-daemon ];
	services.gnome.gnome-keyring.enable = lib.mkForce false;
	programs.ssh.startAgent = true;
	programs.dconf.enable = true;
}
