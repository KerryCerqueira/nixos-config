{ pkgs, flakeInputs, ... }:

{
	imports = [
		../common/libreoffice.nix
		flakeInputs.nvim-config.homeManagerModules.nvim-config
		flakeInputs.shell-config.homeManagerModules.shell-config
	];
	programs = {
		home-manager.enable = true;
		firefox.enable = true;
	};
	home = {
		username = "sara";
		homeDirectory = "/home/sara";
		stateVersion = "23.11";
		packages = with pkgs; [
			gimp
			thunderbird
			zoom-us
			vlc
			spotify
			whatsapp-for-linux
		];
	};
}
