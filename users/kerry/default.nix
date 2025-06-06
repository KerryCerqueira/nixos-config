{ config, pkgs, flakeInputs, ... }:

{
	imports = [
		../common/vscode.nix
		../common/libreoffice.nix
		../common/zathura
		../common/kitty
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
		packages = with pkgs; [
			obsidian
			inkscape-with-extensions
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
	sops = {
		defaultSopsFile = ./secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = "/home/kerry/.config/sops/age/kerry_master.age";
		secrets = {
			"openai_api_key"  = {};
		};
		templates."openai_api_key" = {
			content = "OPENAI_API_KEY=${config.sops.placeholder."openai_api_key"}";
		};
	};
}
