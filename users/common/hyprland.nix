{ pkgs, inputs, ... }:

let
	system = pkgs.stdenv.hostPlatform.system;
	root = inputs.self;
in
{
	home.packages = with pkgs; [
		papirus-icon-theme
		qt6ct
	];
	imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];
	qt = {
		enable = true;
		platformTheme.name = "kvantum";
		style.name = "kvantum";
		style.catppuccin.enable = true;
	};
	gtk = {
		enable = true;
		#TODO: resolve this option if noto sans doesn't exist or add a mechanism to
		# satisfy this dependency
		font.name = "Noto Sans";
		font.size = 10;
		catppuccin.enable = true;
		iconTheme.name = "Papirus-Dark";
		cursorTheme.name = "Catppuccin-Mocha-Dark-Cursors";
	};
	home.file.".config/qt6ct/qt6ct.conf".source = "${root}/dotfiles/qt6ct/qt6ct.conf";
	home.file.".config/kdeglobals".text = ''
	[General]
		TerminalApplication=kitty
	'';
	home.file.".config/waybar/" = {
		source = "${root}/dotfiles/waybar";
		recursive = true;
	};
	wayland.windowManager.hyprland = {
		enable = true;
		plugins = [
			inputs.hyprspace.packages.${system}.Hyprspace
		];
		extraConfig = "source = ./config.d/general.conf";
		package = inputs.hyprland.packages.${system}.hyprland;
		catppuccin.enable = true;
	};
	catppuccin.pointerCursor.enable = true;
	# services.hyprpaper.enable = true;
	# services.hypridle.enable = true;
}
