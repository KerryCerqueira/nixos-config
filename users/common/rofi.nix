{ pkgs, ... }:

{
	programs.rofi = {
		enable = true;
		package = pkgs.rofi-wayland;
		plugins = with pkgs; [
			rofi-calc
			rofi-file-browser
			rofi-power-menu
			rofi-top
		];
	};
}
