{ inputs, pkgs, ... }:

let
	root = inputs.self;
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

	wayland.windowManager.hyprland.settings = {
		exec-once = [ "swaync" ];
		layerrule = [
			"animation slide top, swaync-control-center"
			"animation slide top, swaync-notification-window"
		];
	};

}
