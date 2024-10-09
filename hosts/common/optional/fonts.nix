{ pkgs, ... }:

{
	fonts.packages = with pkgs ; [
		iosevka
		noto-fonts
		(nerdfonts.override {fonts = ["Iosevka"];})
	];
}
