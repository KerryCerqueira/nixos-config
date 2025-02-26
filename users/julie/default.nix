{ pkgs, ... }:

{
	imports = [
		../common/shell-config.nix
		../common/libreoffice.nix
	];
	programs = {
		home-manager.enable = true;
		chromium.enable = true;
		firefox.enable = true;
	};
	home = {
		username = "julie";
		homeDirectory = "/home/julie";
		stateVersion = "23.11";
		packages = with pkgs; [
			xournalpp
			gimp
			thunderbird
			zoom-us
			rnote
			vlc
			spotify
			whatsapp-for-linux
		];
	};
}
