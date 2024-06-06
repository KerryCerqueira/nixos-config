{ config, pkgs, configRoot, ... }:

{
	imports = [
		../common/nvim.nix
		../common/vscode.nix
		../common/shell-config.nix
	];
	home.username = "kerry";
	home.homeDirectory = "/home/kerry";
	home.stateVersion = "23.11";
	programs = {
		home-manager.enable = true;
		zathura.enable = true;
		firefox.enable = true;
	};
	home.packages = with pkgs; [
		keepassxc
		xournalpp
		gimp
		discord
		slack
		thunderbird
		zoom-us
		teams-for-linux
		rnote
	];
	services.easyeffects = if config.networking.hostname == "panza" then {
		enable = true;
		preset = "AdvancedAutoGain";
	} else {};
	home.file = {
		".config/easyeffects/" = {
			source = "${configRoot}/dotfiles/easyeffects/";
			recursive = true;
		};
	};
}
