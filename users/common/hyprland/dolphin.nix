{ inputs, ... }:

let
	root = inputs.self;
in {
	home.file = {
		".local/share/konsole/catppuccin-mocha.colorscheme".source = "${root}/dotfiles/konsole/catppuccin-mocha.colorscheme";
		".local/share/konsole/Default.profile".source = "${root}/dotfiles/konsole/Default.profile";
		".config/konsolerc".source = "${root}/dotfiles/konsole/konsolerc";
	};
}
