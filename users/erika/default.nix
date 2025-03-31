{ pkgs, flakeInputs, ... }:

{
	imports = [
		../common/vscode.nix
		../common/libreoffice.nix
		flakeInputs.nvim-config.homeManagerModules
		flakeInputs.shell-config.homeManagerModules
	];
	programs = {
		home-manager.enable = true;
		chromium.enable = true;
		firefox.enable = true;
	};
	services.syncthing = {
		enable = true;
		tray.enable = true;
		tray.command = "syncthingtray --wait";
	};
	home = {
		username = "erika";
		homeDirectory = "/home/erika";
		stateVersion = "23.11";
		packages = with pkgs; [
			keepassxc
			gimp
			discord
			thunderbird
			zoom-us
			rnote
			vlc
			spotify
			whatsapp-for-linux
		];
	};
}
