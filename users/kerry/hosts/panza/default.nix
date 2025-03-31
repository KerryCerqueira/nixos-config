{ flakeInputs, ... }:
{
	imports = [ flakeInputs.catppuccin.homeModules.catppuccin ];
	catppuccin = {
		gtk.enable = true;
		gtk.gnomeShellTheme = true;
		cursors.enable = true;
	};
	gtk = {
		enable = true;
		#TODO: resolve this option if noto sans doesn't exist or add a mechanism to
		# satisfy this dependency
		font.name = "Noto Sans";
		font.size = 10;
		iconTheme.name = "Papirus-Dark";
		cursorTheme.name = "Catppuccin-Mocha-Dark-Cursors";
	};
	sops = {
		defaultSopsFile = ./secrets.yaml;
		defaultSopsFormat = "yaml";
		age.keyFile = "/home/kerry/.config/sops/age/kerry_master.age";
		secrets = {
			"syncthing/cert" = {
				path = "/home/kerry/.config/syncthing/cert.pem";
			};
			"syncthing/key" = {
				path = "/home/kerry/.config/syncthing/key.pem";
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
	xdg.configFile.".config/easyeffects/" = {
		source = ./easyeffects;
		recursive = true;
	};
}
