{ pkgs, flakeInputs, ... }:

{
	imports = [
		../common/vscode.nix
		../common/libreoffice.nix
		flakeInputs.nvim-config.homeManagerModules.nvim-config
		flakeInputs.shell-config.homeManagerModules.shell-config
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
