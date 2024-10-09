{ inputs, ... }:

let
	root = inputs.self;
in
{
	services.easyeffects = {
		enable = true;
		preset = "AdvancedAutoGain";
	};
	home.file = {
		".config/easyeffects/" = {
			source = "${root}/dotfiles/easyeffects/";
			recursive = true;
		};
	};
}
