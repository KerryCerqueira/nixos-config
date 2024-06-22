{ pkgs, ... }:

{
	fonts.packages = with pkgs ; [
		iosevka
		(nerdfonts.override {fonts = ["Iosevka"];})
	];
}
