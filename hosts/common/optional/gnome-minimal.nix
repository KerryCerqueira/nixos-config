{ pkgs, ... }:

{
	services.xserver.desktopManager.gnome.enable = true;
	environment.gnome.excludePackages = ( with pkgs; [
			gnome-photos
			gnome-tour
	]) ++ (with pkgs.gnome; [
		gnome-music
		gnome-terminal
		epiphany
		geary
		evince
		totem
		tali
		iagno
		hitori
		atomix
	]);
}
