{ ... }:
{
	home.stateVersion = "23.11";
	sops = {
		defaultSopsFormat = "yaml";
		secrets = let
			sopsFile = ./secrets.yaml;
		in {
			"syncthing/cert" = {
				path = "/home/kerry/.config/syncthing/cert.pem";
				inherit sopsFile;
			};
			"syncthing/key" = {
				path = "/home/kerry/.config/syncthing/key.pem";
				inherit sopsFile;
			};
		};
	};
	services = {
		syncthing = {
			enable = true;
			tray.enable = true;
			tray.command = "syncthingtray --wait";
		};
		easyeffects = {
			enable = true;
			preset = "AdvancedAutoGain";
		};
	};
	xdg.configFile = {
		"easyeffects/" = {
			source = ./easyeffects;
			recursive = true;
		};
	};
}
