{ inputs, ... }:

{
	services.easyeffects = {
		enable = true;
		preset = "AdvancedAutoGain";
	};
	home.file = let root = inputs.self; in {
		".config/easyeffects/" = {
			source = "${root}/dotfiles/easyeffects/";
			recursive = true;
		};
	};
}
