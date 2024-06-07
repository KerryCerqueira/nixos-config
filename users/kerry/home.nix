{ config, pkgs, stateVersion, hostName, ... }:

{
	imports = let
		conditionalImports = if hostName == "panza" then [
		../common/easyeffects.nix
		] else [];
	in
		[
		../common/nvim.nix
			../common/vscode.nix
			../common/shell-config.nix
		] ++ conditionalImports;
	users.users.kerry = {
		isNormalUser = true;
		description = "Kerry Cerqueira";
		hashedPasswordFile = config.sops.secrets."hashedUserPasswords/kerry".path;
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.zsh;
	};
	programs = {
		home-manager.enable = true;
		zathura.enable = true;
		firefox.enable = true;
	};
	home = {
		username = "kerry";
		homeDirectory = "/home/kerry";
		stateVersion = stateVersion;
		packages = with pkgs; [
			keepassxc
			xournalpp
			gimp
			discord
			slack
			thunderbird
			zoom-us
			teams-for-linux
			rnote
		];
	};
}
