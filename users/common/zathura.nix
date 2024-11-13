{ inputs, ... }:

let
	root = inputs.self;
in {
	programs.zathura = {
		enable = true;
		extraConfig = "include theme";
	};
	home.file.".config/zathura/theme".source = "${root}/dotfiles/zathura/theme";
}

