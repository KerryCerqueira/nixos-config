{ pkgs, hostName, ... }:

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
			../common/hyprland.nix
			../common/zathura.nix
		] ++ conditionalImports;
	programs = {
		home-manager.enable = true;
		firefox.enable = true;
	};
	home = {
		username = "kerry";
		homeDirectory = "/home/kerry";
		stateVersion = "23.11";
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
			vlc
			spotify
		];
	};
}
