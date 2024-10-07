{ pkgs, inputs, ... }:
let
	system = pkgs.stdenv.hostPlatform.system;
	# hyprland-pkgs = hyprland.inputs.nixpkgs.legacyPackages.${system};
in
{
	nix.settings = {
		substituters = ["https://hyprland.cachix.org"];
		trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
	};
	# hardware.graphics = {
	# 	package = hyprland-pkgs.mesa.drivers;
	# 	package32 = hyprland-pkgs.pkgsi686Linux.mesa.drivers;
	# };
	programs = {
		hyprland = {
			enable = true;
			package = inputs.hyprland.packages.${system}.hyprland;
			portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
		};
		iio-hyprland.enable = true;
		hyprlock.enable = true;
		nm-applet.enable = true;
	};
	services.blueman.enable = true;
	environment.systemPackages = with pkgs; [
		# status bar
		waybar
		# notification daemon
		swaynotificationcenter
		# polkit agent
		kdePackages.polkit-kde-agent-1
		# volume control
		pavucontrol
		# display configuration
		wlr-randr
		kanshi
		# launcher
		rofi-wayland
		# hypr plugins
		hyprlock
		hyprshot
		hyprpaper
	];
}
