{ pkgs, ... }:

{
	powerManagement.enable = true;
	services.desktopManager.gnome.enable = true;
	services.xserver.excludePackages = [ pkgs.xterm ];
	environment.gnome.excludePackages = with pkgs; [
		orca
		evince
		geary
		gnome-photos
		gnome-tour
		gnome-music
		gnome-terminal
		epiphany
		gnome-text-editor
		gnome-calendar
		gnome-console
		gnome-contacts
		gnome-connections
		gnome-music
		totem
	];
	environment.systemPackages = (with pkgs; [
		kitty
	]) ++ (with pkgs.gnomeExtensions; [
			appindicator
			caffeine
			clipboard-indicator
			easyeffects-preset-selector
			places-status-indicator
			auto-move-windows
			launch-new-instance
			removable-drive-menu
			vitals
			quick-settings-tweaker
			impatience
			runcat
		]);
	services.udev.packages = with pkgs; [ gnome-settings-daemon ];
	programs.ssh.startAgent = true;
	programs.dconf.enable = true;
	programs.kdeconnect = {
		enable = true;
		package = pkgs.gnomeExtensions.gsconnect;
	};
}
