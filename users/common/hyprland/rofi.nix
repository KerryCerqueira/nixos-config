{ pkgs, self, ... }:
let
	root = self;
in {
	programs.rofi = {
		enable = true;
		package = pkgs.rofi-wayland;
		plugins = with pkgs; [
			(rofi-calc.override { rofi-unwrapped = rofi-wayland-unwrapped; })
			(rofi-file-browser.override { rofi= rofi-wayland-unwrapped; })
			(rofi-top.override { rofi-unwrapped = rofi-wayland-unwrapped; })
		];
	};
	home.file = {
		".config/rofi/conf.d" = {
			source = "${root}/dotfiles/rofi/";
			recursive = true;
		};
	};
}
