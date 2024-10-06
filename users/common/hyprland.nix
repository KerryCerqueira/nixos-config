{ pkgs, inputs, ... }:

let
	system = pkgs.system;
in
{
	services.hypridle.enable = true;
	wayland.windowManager.hyprland.plugins = [
		inputs.hyprspace.packages.${system}.Hyprspace
	];
}
