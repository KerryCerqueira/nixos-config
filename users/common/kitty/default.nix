{ pkgs, ... }:
{
	catppuccin.kitty.enable = true;
	programs.kitty = {
		enable = true;
		font = {
			package = pkgs.iosevka;
			name = "Iosevka";
		};
		extraConfig = ''
			include ./extra.conf
		'';
	};
}
