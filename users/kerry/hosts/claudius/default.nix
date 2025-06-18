{ ... }:
{
	imports = [
		../../../common/easyeffects.nix
	];
	home.stateVersion = "24.11";
	services = {
		syncthing = {
			enable = true;
			tray.enable = true;
			tray.command = "syncthingtray --wait";
		};
	};
}
