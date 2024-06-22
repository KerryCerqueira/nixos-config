{ pkgs, stateVersion, ... }:

{
	imports = [
		../common/nvim.nix
		../common/vscode.nix
		../common/shell-config.nix
	];
	programs = {
		home-manager.enable = true;
		zathura.enable = true;
		chromium.enable = true;
		firefox.enable = true;
	};
	home = {
		username = "erika";
		homeDirectory = "/home/erika";
		stateVersion = stateVersion;
		packages = with pkgs; [
			xournalpp
			gimp
			discord
			slack
			libreoffice
			thunderbird
			zoom-us
			rnote
		];
	};
}
