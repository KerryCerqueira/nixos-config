{ pkgs, inputs, ... }:
let
	system = pkgs.stdenv.hostPlatform.system;
in
{
	imports = [
		./dolphin.nix
	];
	nix.settings = {
		substituters = ["https://hyprland.cachix.org"];
		trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
	};
	environment.sessionVariables = {
		# hint electron apps to use wayland
		NIXOS_OZONE_WL = "1";
	};
	programs = {
		hyprland = {
			enable = true;
			package = inputs.hyprland.packages.${system}.hyprland;
			portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
		};
		iio-hyprland.enable = true;
		nm-applet.enable = true;
		hyprlock.enable = true;
		ssh.startAgent = true;
		dconf.enable = true;
	};
	services = {
		blueman.enable = true;
		xserver.excludePackages = [ pkgs.xterm ];
		upower.enable = true;
	};
	environment.systemPackages = with pkgs; [
		kitty
		# status bar
		waybar
		# notification daemon
		libnotify
		# volume control
		pavucontrol
		# brightness control
		brightnessctl
		# display configuration
		wlr-randr
		kanshi
		# hypr plugins
		hyprshot
		# clipboard for non windowed applications
		wl-clipboard
		papirus-icon-theme
		wvkbd
		zenity
	];
}
