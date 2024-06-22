{ config, ... }:

{
	services.openvpn.servers = {
		bic = {
			autoStart = false;
			config = "config ${config.sops.secrets."vpnConfs/bic".path}";
			updateResolvConf = true;
		};
	};
}
