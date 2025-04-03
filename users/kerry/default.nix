{ pkgs, flakeInputs, ... }:

{
	imports = [
		../common/vscode.nix
		../common/libreoffice.nix
		../common/zathura
		flakeInputs.nvim-config.homeManagerModules.nvim-config
		flakeInputs.shell-config.homeManagerModules.shell-config
	];
	programs = {
		home-manager.enable = true;
		firefox.enable = true;
		obs-studio.enable = true;
		zathura.enable = true;
	};
	home = {
		username = "kerry";
		homeDirectory = "/home/kerry";
		stateVersion = "23.11";
		packages = with pkgs; [
			keepassxc
			gimp
			discord
			slack
			thunderbird
			zoom-us
			teams-for-linux
			rnote
			vlc
			spotify
			whatsapp-for-linux
		];
	};
}
