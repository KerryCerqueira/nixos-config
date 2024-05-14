# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, configRoot, stateVersion, ... }:

{
	imports = [
		./hardware-configuration.nix
	];
	system.stateVersion = stateVersion;
	fileSystems."/home" = {
		device = "/dev/disk/by-uuid/c67ed632-d694-454d-b39e-95322d23d0a5";
		fsType = "ext4";
	};
	nix.settings.experimental-features = ["nix-command" "flakes"];
	boot.loader.systemd-boot.enable = true;
	boot.loader.systemd-boot.configurationLimit = 1;
	boot.loader.efi.canTouchEfiVariables = true;
	networking.hostName = "panza";
	networking.networkmanager.enable = true;
	time.timeZone = "America/Toronto";
	i18n.defaultLocale = "en_CA.UTF-8";
	services.xserver.enable = true;
	services.xserver.displayManager.gdm.enable = true;
	services.xserver.desktopManager.gnome.enable = true;
	environment.gnome.excludePackages = ( with pkgs; [
			gnome-photos
			gnome-tour
	]) ++ (with pkgs.gnome; [
		gnome-music
		gnome-terminal
		epiphany
		geary
		evince
		totem
		tali
		iagno
		hitori
		atomix
	]);
	services.xserver = {
		xkb.layout = "us";
		xkb.variant = "";
	};
	services.printing.enable = true;
	hardware.sensor.iio.enable = true;
	services.fprintd.enable = true;
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};
	users.users.kerry = {
		isNormalUser = true;
		description = "Kerry Cerqueira";
		extraGroups = [ "networkmanager" "wheel" ];
	};
	nixpkgs.config.allowUnfree = true;
	environment.systemPackages = with pkgs; [
		kitty
		easyeffects
	];
	fonts.packages = with pkgs ; [
		iosevka
		(nerdfonts.override {fonts = ["Iosevka"];})
	];
	environment.variables = {
		ZDOTDIR = "$HOME/.config/zsh";
	};
	users.defaultUserShell = pkgs.zsh;
	programs = {
		zsh.enable = true;
		dconf.enable = true;
		neovim = {
			enable = true;
			defaultEditor = true;
		};
		steam.enable = true;
	};
}
