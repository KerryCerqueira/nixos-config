{ pkgs, ... }:

{
	fonts.packages = with pkgs ; [
		iosevka
		noto-fonts
		nerd-fonts.iosevka
	];
}
