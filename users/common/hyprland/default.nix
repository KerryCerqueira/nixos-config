{ pkgs, self, flakeInputs, ... }:


let
	system = pkgs.stdenv.hostPlatform.system;
	root = self;
in
{
	home.packages = with pkgs; [
		nwg-drawer
		nwg-dock-hyprland
		nwg-displays
		wdisplays
	];
	imports = [
		./dolphin.nix
		./rofi.nix
		./swaync.nix
		./zathura.nix
	];
	catppuccin = {
		cursors.enable = true;
		kvantum.enable = true;
		hyprland.enable = true;
		gtk.enable = true;
	};
	qt = {
		enable = true;
		platformTheme.name = "kvantum";
		style.name = "kvantum";
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
	home.file.".config/qt5ct/qt5ct.conf".source = "${root}/dotfiles/qt5ct/qt5ct.conf";
	home.file.".config/kdeglobals".text = ''
	[General]
		TerminalApplication=kitty
	'';
	home.file.".config/waybar/" = {
		source = "${root}/dotfiles/waybar";
		recursive = true;
	};
	# home.file.".config/hypr/config.d" = {
	# 	source = "${root}/dotfiles/hypr/config.d";
	# 	recursive = true;
	# };
	# home.file.".config/hypr/hyprpaper.conf".source = "${root}/dotfiles/hypr/hyprpaper.conf";
	# home.file.".config/hypr/hyprlock.conf".source = "${root}/dotfiles/hypr/hyprlock.conf";
	# home.file.".config/hypr/hypridle.conf".source = "${root}/dotfiles/hypr/hypridle.conf";
	wayland.windowManager.hyprland = {
		enable = true;
		extraConfig = "source = ./config.d/general.conf";
		package = flakeInputs.hyprland.packages.${system}.hyprland;
		portalPackage = flakeInputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
	};
	services = {
		hyprpaper = {
			enable = true;
			settings = {
				preload = "~/.config/hypr/images/fingerprint.jpg";
				wallpaper = ",~/.config/hypr/images/fingerprint.jpg";
			};
		};
		swayosd.enable = true;
		blueman-applet.enable = true;
		batsignal = {
			enable = true;
			extraArgs = [
				"-P Charging battery"
				"-C Battery critical. System will hibernate at 2% battery."
				"-U Battery discharging"
			];
		};
	};
}
