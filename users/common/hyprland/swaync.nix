{ pkgs, self, ... }:

let
	root = self;
	swayncConfig = (
		builtins.fromJSON (builtins.readFile "${root}/dotfiles/swaync/config.json")
		// {"$schema" = "${pkgs.swaynotificationcenter}/etc/xdg/swaync/configSchema.json";}
	);
in {
	home = {
		packages = [ pkgs.swaynotificationcenter ];
		file = {
			".config/swaync/config.json".text = builtins.toJSON swayncConfig;
		};
	};
}
