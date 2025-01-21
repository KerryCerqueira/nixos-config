{ ... }:
{
	imports = [ ./easyeffects.nix];
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
	services.syncthing = {
		enable = true;
		tray.enable = true;
		tray.command = "syncthingtray --wait";
	};
}
