{ inputs, config, pkgs, ... }:
let
	root = inputs.self;
	inherit (config.lib.formats.rasi) mkLiteral;
in {
	programs.rofi = {
		enable = true;
		# package = pkgs.rofi-wayland;
		plugins = with pkgs; [
			rofi-calc
			rofi-file-browser
			rofi-top
		];
	};
	home.file = {
		".config/rofi/conf.d" = {
			source = "${root}/dotfiles/rofi/";
			recursive = true;
		};
	};
}
