{ configRoot, ... }:

{
	services.easyeffects = {
		enable = true;
		preset = "AdvancedAutoGain";
	};
	home.file = {
		".config/easyeffects/" = {
			source = "${configRoot}/dotfiles/easyeffects/";
			recursive = true;
		};
	};
}
