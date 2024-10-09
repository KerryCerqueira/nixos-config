{ pkgs, inputs, ... }:
let
	system = pkgs.stdenv.hostPlatform.system;
	# hyprland-pkgs = hyprland.inputs.nixpkgs.legacyPackages.${system};
in
{
	# hardware.graphics = {
	# 	package = hyprland-pkgs.mesa.drivers;
	# 	package32 = hyprland-pkgs.pkgsi686Linux.mesa.drivers;
	# };
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
	services.blueman.enable = true;
	services.udisks2.enable = true;
	environment.systemPackages = with pkgs; [
		# status bar
		waybar
		# notification daemon
		swaynotificationcenter
		# kde wayland support
		kdePackages.qtwayland
		# polkit agent
		kdePackages.polkit-kde-agent-1
		# file manager
		kdePackages.dolphin
		kdePackages.dolphin-plugins
		# icon support for dolphin
		kdePackages.qtsvg
		# thumbnailers and file previews for dolphin
		kdePackages.kdegraphics-thumbnailers
		kdePackages.kimageformats
		kdePackages.qtimageformats
		kdePackages.kdesdk-thumbnailers
		kdePackages.ffmpegthumbs
		kdePackages.taglib
		resvg
		kdePackages.kio-fuse #to mount remote filesystems via FUSE
		kdePackages.kio-extras #extra protocols support (sftp, fish and more)
		kdePackages.kio-zeroconf
		kdePackages.kio-gdrive
		# terminal for dolphin
		kdePackages.konsole
		# compare tool for dolphin
		kdePackages.kompare
		# metadata search for dolphin
		kdePackages.baloo
		# file archiver
		kdePackages.ark
		# volume control
		pavucontrol
		# brightness control
		brightnessctl
		# display configuration
		wlr-randr
		kanshi
		wdisplays
		# launcher
		rofi-wayland
		# hypr plugins
		hyprshot
		# clipboard for non windowed applications
		wl-clipboard
	];
}
